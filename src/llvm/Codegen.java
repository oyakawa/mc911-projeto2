/*****************************************************
Esta classe Codegen é a responsável por emitir LLVM-IR. 
Ela possui o mesmo método 'visit' sobrecarregado de
acordo com o tipo do parâmetro. Se o parâmentro for
do tipo 'While', o 'visit' emitirá código LLVM-IR que 
representa este comportamento. 
Alguns métodos 'visit' já estão prontos e, por isso,
a compilação do código abaixo já é possível.

class a{
    public static void main(String[] args){
    	System.out.println(1+2);
    }
}

O pacote 'llvmast' possui estruturas simples 
que auxiliam a geração de código em LLVM-IR. Quase todas 
as classes estão prontas; apenas as seguintes precisam ser 
implementadas: 

// llvmasm/LlvmBranch.java OK
// llvmasm/LlvmIcmp.java OK
// llvmasm/LlvmMinus.java OK
// llvmasm/LlvmTimes.java OK


Todas as assinaturas de métodos e construtores 
necessárias já estão lá. 


Observem todos os métodos e classes já implementados
e o manual do LLVM-IR (http://llvm.org/docs/LangRef.html) 
como guia no desenvolvimento deste projeto. 

****************************************************/
package llvm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import llvmast.LlvmAlloca;
import llvmast.LlvmArray;
import llvmast.LlvmBitcast;
import llvmast.LlvmBool;
import llvmast.LlvmBranch;
import llvmast.LlvmCall;
import llvmast.LlvmCloseDefinition;
import llvmast.LlvmConstantDeclaration;
import llvmast.LlvmDefine;
import llvmast.LlvmExternalDeclaration;
import llvmast.LlvmGetElementPointer;
import llvmast.LlvmIcmp;
import llvmast.LlvmInstruction;
import llvmast.LlvmIntegerLiteral;
import llvmast.LlvmLabel;
import llvmast.LlvmLabelValue;
import llvmast.LlvmLoad;
import llvmast.LlvmMinus;
import llvmast.LlvmNamedValue;
import llvmast.LlvmPlus;
import llvmast.LlvmPointer;
import llvmast.LlvmPrimitiveType;
import llvmast.LlvmRegister;
import llvmast.LlvmRet;
import llvmast.LlvmStore;
import llvmast.LlvmStructure;
import llvmast.LlvmTimes;
import llvmast.LlvmType;
import llvmast.LlvmValue;
import semant.Env;
import syntaxtree.And;
import syntaxtree.ArrayAssign;
import syntaxtree.ArrayLength;
import syntaxtree.ArrayLookup;
import syntaxtree.Assign;
import syntaxtree.Block;
import syntaxtree.BooleanType;
import syntaxtree.Call;
import syntaxtree.ClassDecl;
import syntaxtree.ClassDeclExtends;
import syntaxtree.ClassDeclSimple;
import syntaxtree.Equal;
import syntaxtree.False;
import syntaxtree.Formal;
import syntaxtree.Identifier;
import syntaxtree.IdentifierExp;
import syntaxtree.IdentifierType;
import syntaxtree.If;
import syntaxtree.IntArrayType;
import syntaxtree.IntegerLiteral;
import syntaxtree.IntegerType;
import syntaxtree.LessThan;
import syntaxtree.MainClass;
import syntaxtree.MethodDecl;
import syntaxtree.Minus;
import syntaxtree.NewArray;
import syntaxtree.NewObject;
import syntaxtree.Not;
import syntaxtree.Plus;
import syntaxtree.Print;
import syntaxtree.Program;
import syntaxtree.Statement;
import syntaxtree.This;
import syntaxtree.Times;
import syntaxtree.True;
import syntaxtree.VarDecl;
import syntaxtree.VisitorAdapter;
import syntaxtree.While;

public class Codegen extends VisitorAdapter{
	private List<LlvmInstruction> assembler;
	private Codegen codeGenerator;

  	private SymTab symTab = new SymTab();
	private ClassNode classEnv; 	// Aponta para a classe atualmente em uso em symTab
	private MethodNode methodEnv; 	// Aponta para a metodo atualmente em uso em symTab
	
	private int ifCount;
	private int whileCount;
	private int entryCount;


	public Codegen(){
		assembler = new LinkedList<LlvmInstruction>();
		ifCount = 0;
		whileCount = 0;
		entryCount = 0;
	}

	// Método de entrada do Codegen
	public String translate(Program p, Env env){	
		codeGenerator = new Codegen();
		
		// Preenchendo a Tabela de Símbolos
		// Quem quiser usar 'env', apenas comente essa linha
		codeGenerator.symTab.FillTabSymbol(p);
		
		// Formato da String para o System.out.printlnijava "%d\n"
		codeGenerator.assembler.add(new LlvmConstantDeclaration("@.formatting.string", "private constant [4 x i8] c\"%d\\0A\\00\""));	

		// NOTA: sempre que X.accept(Y), então Y.visit(X);
		// NOTA: Logo, o comando abaixo irá chamar codeGenerator.visit(Program), linha 75
		p.accept(codeGenerator);

		// Links do printf e do malloc
		List<LlvmType> pts = new LinkedList<LlvmType>();
		pts.add(new LlvmPointer(LlvmPrimitiveType.I8));
		pts.add(LlvmPrimitiveType.DOTDOTDOT);
		codeGenerator.assembler.add(new LlvmExternalDeclaration("@printf", LlvmPrimitiveType.I32, pts)); 
		List<LlvmType> mallocpts = new LinkedList<LlvmType>();
		mallocpts.add(LlvmPrimitiveType.I32);
		codeGenerator.assembler.add(new LlvmExternalDeclaration("@malloc", new LlvmPointer(LlvmPrimitiveType.I8),mallocpts)); 


		String r = new String();
		for(LlvmInstruction instr : codeGenerator.assembler)
			r += instr+"\n";
		return r;
	}

	public LlvmValue visit(Program n){
		n.mainClass.accept(this);

		for (util.List<ClassDecl> c = n.classList; c != null; c = c.tail)
			c.head.accept(this);

		return null;
	}

	public LlvmValue visit(MainClass n){
		
		ClassNode aux = symTab.classes.get(n.className.s);
		assembler.add(new LlvmConstantDeclaration(
				aux.toString(),
				"type "+aux.getClassType().toString()));
		
		// definicao do main 
		assembler.add(new LlvmDefine("@main", LlvmPrimitiveType.I32, new LinkedList<LlvmValue>()));
		assembler.add(new LlvmLabel(new LlvmLabelValue("entry")));
		LlvmRegister R1 = new LlvmRegister(new LlvmPointer(LlvmPrimitiveType.I32));
		assembler.add(new LlvmAlloca(R1, LlvmPrimitiveType.I32, new LinkedList<LlvmValue>()));
		assembler.add(new LlvmStore(new LlvmIntegerLiteral(0), R1));

		// Statement é uma classe abstrata
		// Portanto, o accept chamado é da classe que implementa Statement, por exemplo,  a classe "Print". 
		n.stm.accept(this);  

		// Final do Main
		LlvmRegister R2 = new LlvmRegister(LlvmPrimitiveType.I32);
		assembler.add(new LlvmLoad(R2,R1));
		assembler.add(new LlvmRet(R2));
		assembler.add(new LlvmCloseDefinition());
		return null;
	}
	
	public LlvmValue visit(Plus n){
		
		LlvmValue v1 = n.lhs.accept(this);
		LlvmValue v2 = n.rhs.accept(this);
		LlvmRegister lhs = new LlvmRegister(LlvmPrimitiveType.I32);
		assembler.add(new LlvmPlus(lhs,LlvmPrimitiveType.I32,v1,v2));
		return lhs;
	}
	
	public LlvmValue visit(Print n){

		LlvmValue v =  n.exp.accept(this);

		// getelementptr:
		LlvmRegister lhs = new LlvmRegister(new LlvmPointer(LlvmPrimitiveType.I8));
		LlvmRegister src = new LlvmNamedValue("@.formatting.string",new LlvmPointer(new LlvmArray(4,LlvmPrimitiveType.I8)));
		List<LlvmValue> offsets = new LinkedList<LlvmValue>();
		offsets.add(new LlvmIntegerLiteral(0));
		offsets.add(new LlvmIntegerLiteral(0));
		List<LlvmType> pts = new LinkedList<LlvmType>();
		pts.add(new LlvmPointer(LlvmPrimitiveType.I8));
		List<LlvmValue> args = new LinkedList<LlvmValue>();
		args.add(lhs);
		args.add(v);
		assembler.add(new LlvmGetElementPointer(lhs,src,offsets));

		pts = new LinkedList<LlvmType>();
		pts.add(new LlvmPointer(LlvmPrimitiveType.I8));
		pts.add(LlvmPrimitiveType.DOTDOTDOT);
		
		// printf:
		assembler.add(new LlvmCall(new LlvmRegister(LlvmPrimitiveType.I32),
				LlvmPrimitiveType.I32,
				pts,				 
				"@printf",
				args
				));
		return null;
	}
	
	public LlvmValue visit(IntegerLiteral n){
		return new LlvmIntegerLiteral(n.value);
	}
	
	// Todos os visit's que devem ser implementados	
	public LlvmValue visit(ClassDeclSimple n){
		
		ClassNode classNode = symTab.classes.get(n.name.s);
		classEnv = classNode;
		Map<Integer, MethodNode> methods = classNode.getMethodIndex();
		
		assembler.add(new LlvmConstantDeclaration(
				classNode.toString(),
				"type "+classNode.getClassType()));
		
		// Accept each method
		for (util.List<MethodDecl> c = n.methodList; c != null; c = c.tail) {
			c.head.accept(this);
		}
		
		MethodNode constructor = symTab.methods.get(
				"@__"+n.name.s+"Constructor"+"_"+n.name.s);
		// Generate constructor code
		assembler.add(new LlvmDefine(
				constructor.getNameMethod(),
				constructor.getMethodType(),
				constructor.getFormalList()));
		assembler.add(new LlvmLabel(new LlvmLabelValue("entry"+entryCount++)));
		assembler.add(new LlvmRet(new LlvmRegister("%this", constructor.getMethodType())));
		assembler.add(new LlvmCloseDefinition());
		
		return null;
	}
	
	public LlvmValue visit(ClassDeclExtends n){
		
		ClassNode classNode = symTab.classes.get(n.name.s);
		ClassNode superClass = classNode.getSuperClass();
		classEnv = classNode;
		Map<Integer, MethodNode> methods = classNode.getMethodIndex();
		
		assembler.add(new LlvmConstantDeclaration(
				classNode.toString(),
				"type "+classNode.getClassType()));
		
		// Accept each method
		for (util.List<MethodDecl> c = n.methodList; c != null; c = c.tail) {
			c.head.accept(this);
		}
		
		MethodNode constructor = symTab.methods.get(
				"@__"+n.name.s+"Constructor"+"_"+n.name.s);
		// Generate constructor code
		assembler.add(new LlvmDefine(
				constructor.getNameMethod(),
				constructor.getMethodType(),
				constructor.getFormalList()));
		assembler.add(new LlvmLabel(new LlvmLabelValue("entry"+entryCount++)));
		
		
		// TODO complete specific superclass modifications here
		
		//LlvmRegister superPointer = new LlvmRegister(new LlvmPointer(superClass));
		//LlvmRegister thisPointer = new LlvmRegister("%this", new LlvmPointer(classNode));
		//assembler.add(new LlvmBitcast(superPointer, thisPointer, superPointer.type));
		
		
		assembler.add(new LlvmRet(new LlvmRegister("%this", constructor.getMethodType())));
		assembler.add(new LlvmCloseDefinition());
		return null;
	}
	
	public LlvmValue visit(VarDecl n){
		
		LlvmRegister ret = new LlvmRegister(
				"%"+n.name.s, 
				new LlvmPointer(n.type.accept(this).type));
		assembler.add(new LlvmAlloca(ret, n.type.accept(this).type, new ArrayList<LlvmValue>()));
		return ret;
	}
	
	public LlvmValue visit(MethodDecl n){
		
		MethodNode methodNode = symTab.methods.get(
				"@__"+n.name.s+"_"+classEnv.getNameClass());
		
		methodEnv = methodNode;
		
		// Add method's definition
		assembler.add(new LlvmDefine(
				methodNode.getNameMethod(),
				methodNode.getMethodType(),
				methodNode.getFormalList()));
		
		assembler.add(new LlvmLabel(new LlvmLabelValue("entry"+entryCount++)));
		
		// Allocate space for formals
		for (util.List<Formal> f = n.formals; f != null; f = f.tail) {
			f.head.accept(this);
		}
		
		// Allocate space for locals
		for (util.List<VarDecl> l = n.locals; l != null; l = l.tail) {
			l.head.accept(this);
		}
		
		// Generate method's body and return
		for (util.List<Statement> i = n.body; i != null; i = i.tail) {
			i.head.accept(this);
		}
		assembler.add(new LlvmRet(n.returnExp.accept(this)));
		
		// Close method's definition
		assembler.add(new LlvmCloseDefinition());
		return null;
	}
	
	public LlvmValue visit(Formal n){
		LlvmRegister ret = new LlvmRegister("%"+n.name.s+"_tmp", new LlvmPointer(n.type.accept(this).type));
		assembler.add(new LlvmAlloca(ret, n.type.accept(this).type, new ArrayList<LlvmValue>()));
		LlvmRegister content = new LlvmRegister("%"+n.name.s, n.type.accept(this).type);
		assembler.add(new LlvmStore(content, ret));
		return ret;
	}
	
	public LlvmValue visit(IntArrayType n){
		return new LlvmNamedValue("i32 *", new LlvmPointer(LlvmPrimitiveType.I32));
	}
	
	public LlvmValue visit(BooleanType n){
		return new LlvmNamedValue("i1", LlvmPrimitiveType.I1);
	}
	
	public LlvmValue visit(IntegerType n){
		return new LlvmNamedValue("i32", LlvmPrimitiveType.I32);
	}
	
	public LlvmValue visit(IdentifierType n){
		return new LlvmNamedValue("%class." + n.name, new LlvmPointer(
				LlvmPrimitiveType.I8)); // TODO check
	}
	
	public LlvmValue visit(Block n){
		
		int i, j;
		j = n.body.size();
		for(i = 0; i < j; i++){
			n.body.head.accept(this);
			n.body = n.body.tail;
		}		
		return null;
		
	}
	
	public LlvmValue visit(If n){
				
		LlvmLabelValue ifThenLabel = new LlvmLabelValue("ifThen"+ifCount);
		LlvmLabelValue ifElseLabel = new LlvmLabelValue("ifElse"+ifCount);
		LlvmLabelValue ifEndLabel = new LlvmLabelValue("ifEnd"+ifCount);
		ifCount++;
		
		LlvmValue cond = n.condition.accept(this);
		assembler.add(new LlvmBranch(cond,
					ifThenLabel,
					ifElseLabel)
				);		
		
		LlvmLabel ifThen = new LlvmLabel(ifThenLabel);
		assembler.add(ifThen);
		n.thenClause.accept(this);
		assembler.add(new LlvmBranch(ifEndLabel));
		
		LlvmLabel ifElse = new LlvmLabel(ifElseLabel);
		assembler.add(ifElse);
		if (n.elseClause != null) {
			n.elseClause.accept(this);
		}
		assembler.add(new LlvmBranch(ifEndLabel));
		
		LlvmLabel ifEnd = new LlvmLabel(ifEndLabel);
		assembler.add(ifEnd);
		return null;
		
	}
	
	public LlvmValue visit(While n){
		
		LlvmLabelValue whileCondLabel = new LlvmLabelValue("whileCond"+whileCount);
		LlvmLabelValue whileBodyLabel = new LlvmLabelValue("whileBody"+whileCount);
		LlvmLabelValue whileEndLabel = new LlvmLabelValue("whileEnd"+whileCount);
		whileCount++;
		
		LlvmLabel whileCond = new LlvmLabel(whileCondLabel);
		assembler.add(whileCond);
		
		LlvmValue cond = n.condition.accept(this);
		assembler.add(new LlvmBranch(cond,
					whileBodyLabel,
					whileEndLabel)
				);		
		
		LlvmLabel whileBody = new LlvmLabel(whileBodyLabel);
		assembler.add(whileBody);
		n.body.accept(this);
		assembler.add(new LlvmBranch(whileCondLabel));
		
		LlvmLabel whileEnd = new LlvmLabel(whileEndLabel);
		assembler.add(whileEnd);
		return null;
		
	}
	
	public LlvmValue visit(Assign n){
		
		LlvmValue var = n.var.accept(this);
		LlvmValue exp = n.exp.accept(this);
		if (var == null) {
			LlvmRegister address = new LlvmRegister("%"+n.var.s, new LlvmPointer(exp.type));
			assembler.add(new LlvmStore(exp, address));
		} else {
			assembler.add(new LlvmStore(exp, var));
		}
		return null;
		
	}
	
	public LlvmValue visit(ArrayAssign n){
		LlvmValue variable = n.var.accept(this);
		LlvmValue index    = n.index.accept(this);
		LlvmValue value    = n.value.accept(this);
		
		/**
		 *  TODO: Alocar o nó 0 (zero) do Array para servir como
		 * um nó sentinela. Se a alocação exigir 10 posições de
		 * vetor, então vamos alocar 11 posições, de 0 a 10, onde
		 * a posição 0 (zero) contém o tamanho do vetor, e os índices
		 * de 1 a 10 contém os valores propriamente ditos.
		 */
		
		//LlvmRegister address = new LlvmRegister("%"+n.var.s, new LlvmPointer(exp.type));
		//assembler.add(new LlvmGetElementPointer(exp, address));
		return null;
	}
	
	public LlvmValue visit(And n){
		
		LlvmValue lhs = n.lhs.accept(this);
		LlvmValue rhs = n.rhs.accept(this);
		LlvmRegister mul = new LlvmRegister(lhs.type);
		assembler.add(new LlvmTimes(mul, lhs.type, lhs, rhs));
		LlvmRegister res = new LlvmRegister(LlvmPrimitiveType.I1);
		assembler.add(new LlvmIcmp(res, 2, mul.type, mul, new LlvmIntegerLiteral(0)));
		return res;
		
	}
	
	public LlvmValue visit(LessThan n){
		
		LlvmValue v1 = n.lhs.accept(this);
		LlvmValue v2 = n.rhs.accept(this);
		LlvmRegister lhs = new LlvmRegister(LlvmPrimitiveType.I32);
		assembler.add(new LlvmIcmp(lhs,9,LlvmPrimitiveType.I32,v1,v2));
		return lhs;
		
	}
	
	public LlvmValue visit(Equal n){
		
		LlvmValue v1 = n.lhs.accept(this);
		LlvmValue v2 = n.rhs.accept(this);
		LlvmRegister lhs = new LlvmRegister(LlvmPrimitiveType.I32);
		assembler.add(new LlvmIcmp(lhs,1,LlvmPrimitiveType.I32,v1,v2));
		return lhs;
		
	}
	
	public LlvmValue visit(Minus n){
		
		LlvmValue v1 = n.lhs.accept(this);
		LlvmValue v2 = n.rhs.accept(this);
		LlvmRegister lhs = new LlvmRegister(LlvmPrimitiveType.I32);
		assembler.add(new LlvmMinus(lhs,LlvmPrimitiveType.I32,v1,v2));
		return lhs;
		
	}
	
	public LlvmValue visit(Times n){
		
		LlvmValue v1 = n.lhs.accept(this);
		LlvmValue v2 = n.rhs.accept(this);
		LlvmRegister lhs = new LlvmRegister(LlvmPrimitiveType.I32);
		assembler.add(new LlvmTimes(lhs,LlvmPrimitiveType.I32,v1,v2));
		return lhs;
		
	}
	
	public LlvmValue visit(ArrayLookup n){
		// TODO: almost sure it is working, didn't test yet.
		LlvmValue index = n.index.accept(this);
		LlvmValue len = n.array.accept(this);
		
		LlvmRegister lhs = new LlvmRegister(LlvmPrimitiveType.I32);
		LlvmPlus lookup = new LlvmPlus(lhs, LlvmPrimitiveType.I32, index, len);
		assembler.add(lookup);
		
		return lhs;
	}
	
	public LlvmValue visit(ArrayLength n){
		LlvmValue len;
		len = n.array.type.accept(this);
		return len;
	}
	
	public LlvmValue visit(Call n){
				
		LlvmRegister ret = new LlvmRegister(n.type.accept(this).type);
		List<LlvmValue> args = new ArrayList<LlvmValue>();
		int i, j;
		
		/**
		 * TODO: Testar se o objeto em questão é o %this ou não.
		 * Se for, converter o tipo dele antes de continuar. 
		 */
		if (n.object.toString().equals("this")){
			LlvmValue thisObj = n.object.accept(this);
			LlvmValue thisObjPtr = new LlvmRegister(
					new LlvmPointer(thisObj.type));
			assembler.add(new LlvmLoad(thisObjPtr, thisObj));
			args.add(thisObjPtr);
		} else {	
			args.add(n.object.accept(this));
		}
		if (n.actuals != null) {
			for (i = 0, j = n.actuals.size(); i < j; i++) {
				args.add(n.actuals.head.accept(this));
				n.actuals = n.actuals.tail;
			}
		}
		
		assembler.add(new LlvmCall(
				ret,
				ret.type,
				"@__"+n.method.s+"_"+n.object.type.toString(),
				args
				));
		return ret;	// TODO update		
	}
	
	public LlvmValue visit(True n){		
		return new LlvmBool(1);		
	}
	
	public LlvmValue visit(False n){		
		return new LlvmBool(0);		
	}
	
	public LlvmValue visit(IdentifierExp n){
		
		LlvmValue ref = n.name.accept(this);
		if (ref != null) {
			LlvmRegister ret = new LlvmRegister(methodEnv.getMethodType());
			assembler.add(new LlvmLoad(ret, ref));
			return ret;
		}
		return null;
	}
	
	public LlvmValue visit(This n){
		LlvmRegister ret = new LlvmRegister(classEnv);
		assembler.add(new LlvmLoad(
				ret,
				new LlvmRegister("%this", new LlvmPointer(classEnv))
				));
		return ret;
	}
	
	
	public LlvmValue visit(NewArray n){
		LlvmRegister array = new LlvmRegister(n.type.accept(this).type);
		LlvmValue qty = n.size.accept(this);
		List<LlvmValue> numbers = new ArrayList<LlvmValue>();
		numbers.add(qty);
		assembler.add(new LlvmAlloca(array, LlvmPrimitiveType.I32, numbers));
		return array;
	}
	
	public LlvmValue visit(NewObject n){
		
		ClassNode thisClass = symTab.classes.get(n.className.s);
		
		LlvmRegister newObj = new LlvmRegister(
				new LlvmPointer(thisClass));
		
		
		LlvmRegister malReg = new LlvmRegister(new LlvmPointer(LlvmPrimitiveType.I8));
		List<LlvmValue> listMalReg = new ArrayList<LlvmValue>();
		listMalReg.add(
				new LlvmIntegerLiteral(thisClass.getClassType().sizeByte+8)
				);
		
		assembler.add(new LlvmCall(
				malReg,
				new LlvmPointer(LlvmPrimitiveType.I8),
				"@malloc",
				listMalReg
				));
		  
		LlvmRegister bitReg = new LlvmRegister(new LlvmPointer(thisClass));
		
		
		assembler.add(new LlvmBitcast(
				bitReg,
				malReg,
				new LlvmPointer(thisClass)
				));
		
		List<LlvmValue> listNewObjReg = new ArrayList<LlvmValue>();
		listNewObjReg.add(bitReg);
		assembler.add(new LlvmCall(
				newObj,
				new LlvmPointer(thisClass),
				"@__" + n.className.s + "Constructor" + "_" + n.className.s,
				listNewObjReg
				));

		return newObj;
	}
	
	public LlvmValue visit(Not n){
		
        LlvmValue v1 = n.exp.accept(this);
        int value = 0;
        if (v1.equals(new LlvmBool(1))) {
        	value = 1;
        }
        int ret = 1 - value;
        return new LlvmBool(ret);
        
	}
	
	public LlvmValue visit(Identifier n){
		
		int i = 1;
		for (LlvmValue lv : classEnv.getVarList()) {
			LlvmRegister lr = (LlvmRegister) lv;
			// se referência for encontrada em classEnv (slide 46)
			if (lr.name.equals("%"+n.s)) {
				// bitcast no caso de herança (?)
				// getelementptr
				LlvmRegister ref = new LlvmRegister(
						new LlvmPointer(lr.type));
				List<LlvmValue> offsets = new ArrayList<LlvmValue>();
				offsets.add(new LlvmIntegerLiteral(0));
				/* se tipo for array
				 * if () {
					
				}*/
				offsets.add(new LlvmIntegerLiteral(i));

				assembler.add(new LlvmGetElementPointer(
						ref,
						new LlvmRegister("%this",
								new LlvmPointer(classEnv)),
						offsets
						));
				return ref;
			}
			i++;
		}
		// se não encontrou, deve ser formal do método
		for (LlvmValue lv : methodEnv.getFormalList()) {
			LlvmRegister lr = (LlvmRegister) lv;
			if (lr.name.equals("%"+n.s)) {
				return new LlvmRegister(
						"%"+n.s+"_tmp",
						new LlvmPointer(lr.type));
			}
		}
		// se não encontrou, deve ser local do método
				for (LlvmValue lv : methodEnv.getLocalList()) {
					LlvmRegister lr = (LlvmRegister) lv;
					if (lr.name.equals("%"+n.s)) {
						return new LlvmRegister
								(lr.name, new LlvmPointer(lr.type));
					}
				}
		
		// se ainda não encontrou, erro (?)
		return null;
	}
}


/**********************************************************************************/
/* === Tabela de Símbolos ==== 
 * 
 * 
 */
/**********************************************************************************/

class SymTab extends VisitorAdapter{
    public Map<String, ClassNode> classes;
    public Map<String, MethodNode> methods;
    private ClassNode classEnv;    //aponta para a classe em uso
    
    public SymTab(){
    	classes = new HashMap<String, ClassNode>();
    	methods = new HashMap<String, MethodNode>();
    }

    public LlvmValue FillTabSymbol(Program n){
		n.accept(this);
		return null;
	}
	public LlvmValue visit(Program n){
		n.mainClass.accept(this);
	
		for (util.List<ClassDecl> c = n.classList; c != null; c = c.tail)
			c.head.accept(this);
	
		return null;
	}
	
	public LlvmValue visit(MainClass n){
		classEnv = classes.put(n.className.s, new ClassNode(
				n.className.s,
				new LlvmStructure(new ArrayList<LlvmType>()), 
				new ArrayList<LlvmValue>()));
		return null;
	}
	
	public LlvmValue visit(ClassDeclSimple n){
		
		List<LlvmValue> varList = new ArrayList<LlvmValue>();		
		List<LlvmType> typeList = new ArrayList<LlvmType>();		

		// Constroi VarList com as Variáveis da Classe
		// Constroi TypeList com os tipos das variáveis da Classe (vai formar a Struct da classe)		
		int i, j;
		if(n.methodList != null && n.methodList.size() > 0)
			typeList.add(new LlvmArray(n.methodList.size(), new LlvmPointer(LlvmPrimitiveType.I8)));
		if(n.varList != null && n.varList.size() > 0){
			j = n.varList.size();
			util.List<VarDecl> aux = n.varList;
			for(i = 0; i < j; i++) {
				varList.add(aux.head.accept(this));
				LlvmType auxType = aux.head.type.accept(this).type;
				typeList.add(auxType);
				aux = aux.tail;
			}
		}
		
		if(classes.containsKey(n.name.s)) {
			classEnv = classes.get(n.name.s);
		} else {
			classEnv = new ClassNode(
					n.name.s,
					new LlvmStructure(typeList),
					varList);
		}
		
	    // Percorre n.methodList visitando cada método
		if(n.methodList != null && n.methodList.size() > 0){
			j = n.methodList.size();
			util.List<MethodDecl> aux2 = n.methodList;
			for(i = 0; i < j; i++) {
				aux2.head.accept(this);
				aux2 = aux2.tail;
			}
		}		
		
		// Adds constructor method info
		MethodNode constructor = new MethodNode(
				"@__"+n.name.s+"Constructor"+"_"+n.name.s, 
				null, 
				new ArrayList<LlvmValue>());
		List<LlvmValue> constructorFormals = new ArrayList<LlvmValue>();
		constructorFormals.add(new LlvmRegister("%this", new LlvmPointer(classEnv)));
		constructor.setFormalList(constructorFormals);
		constructor.setMethodType(new LlvmPointer(classEnv));
		methods.put("@__"+n.name.s+"Constructor"+"_"+n.name.s, constructor);		
		
		classEnv = classes.put(n.name.s, classEnv);		
		
		return null;
	}

	public LlvmValue visit(ClassDeclExtends n){
		List<LlvmValue> varList = new ArrayList<LlvmValue>();		
		List<LlvmType> typeList = new ArrayList<LlvmType>();		

		// Constroi VarList com as Variáveis da Classe
		// Constroi TypeList com os tipos das variáveis da Classe (vai formar a Struct da classe)		
		int i, j;
		if(n.methodList != null && n.methodList.size() > 0)
			typeList.add(new LlvmArray(n.methodList.size(), new LlvmPointer(LlvmPrimitiveType.I8)));
		if(n.varList != null && n.varList.size() > 0){
			j = n.varList.size();
			util.List<VarDecl> aux = n.varList;
			for(i = 0; i < j; i++) {
				varList.add(aux.head.accept(this));
				typeList.add(aux.head.type.accept(this).type);
				aux = aux.tail;
			}
		}
		
		if(classes.containsKey(n.name.s)) {
			classEnv = classes.get(n.name.s);
		} else {
			classEnv = new ClassNode(
					n.name.s,
					new LlvmStructure(typeList),
					varList);
		}
		
	    // Percorre n.methodList visitando cada método
		if(n.methodList != null && n.methodList.size() > 0){
			j = n.methodList.size();
			util.List<MethodDecl> aux2 = n.methodList;
			for(i = 0; i < j; i++) {
				aux2.head.accept(this);
				aux2 = aux2.tail;
			}
		}
		
		ClassNode superClass;
		if(classes.containsKey(n.superClass.s)) {
			superClass = classes.get(n.superClass.s);
		} else {
			superClass = new ClassNode(
					n.superClass.s,
					null,
					new ArrayList<LlvmValue>());
		}
		
		// Add constructor info
		MethodNode constructor = new MethodNode(
				"@__"+n.name.s+"Constructor"+"_"+n.name.s, 
				null, 
				new ArrayList<LlvmValue>());
		List<LlvmValue> constructorFormals = new ArrayList<LlvmValue>();
		constructorFormals.add(new LlvmRegister("%this", new LlvmPointer(classEnv)));
		constructor.setFormalList(constructorFormals);
		constructor.setMethodType(new LlvmPointer(classEnv));
		methods.put("@__"+n.name.s+"Constructor"+"_"+n.name.s, constructor);	
		
		classEnv.setSuperClass(superClass);
		classEnv = classes.put(n.name.s, classEnv);
		
		return null;
	}
	
	public LlvmValue visit(VarDecl n){
		return new LlvmRegister("%"+n.name.s, n.type.accept(this).type); //TODO check if enough
	}
	
	public LlvmValue visit(Formal n){
		return new LlvmRegister("%"+n.name.s, n.type.accept(this).type);
	}
	
	public LlvmValue visit(MethodDecl n){
		
		int i, j;
		List<LlvmValue> formalList = new ArrayList<LlvmValue>();		
		List<LlvmValue> localList = new ArrayList<LlvmValue>();
		
		// Percorre n.formals
		formalList.add(new LlvmRegister("%this", new LlvmPointer(classEnv)));
		if(n.formals != null && n.formals.size() > 0){
			j = n.formals.size();
			util.List<Formal> aux2 = n.formals;
			for(i = 0; i < j; i++) {
				formalList.add(aux2.head.accept(this));
				aux2 = aux2.tail;
			}
		}

		// Percorre n.locals
		if(n.locals != null && n.locals.size() > 0){
			j = n.locals.size();
			util.List<VarDecl> aux2 = n.locals;
			for(i = 0; i < j; i++) {
				localList.add(aux2.head.accept(this));
				aux2 = aux2.tail;
			}
		}
		
		MethodNode methodEnv = new MethodNode(
				"@__" + n.name.s + "_" + classEnv.getNameClass(),
				formalList,
				localList);
		
		LlvmValue valueAux =  n.returnType.accept(this);
		if(valueAux.type == LlvmPrimitiveType.LABEL) {
			ClassNode classRef;
			if(classes.containsKey(valueAux.toString())) {
				classRef = classes.get(valueAux.toString());
			} else {
				classRef = new ClassNode(valueAux.toString(), null, new ArrayList<LlvmValue>());
			}
			methodEnv.setMethodType(classRef);
		} else {
			methodEnv.setMethodType(valueAux.type);
		}
		
		Map<Integer, MethodNode> aux = classEnv.getMethodIndex();
		aux.put(classEnv.getMethodCount(), methodEnv);
		
		classEnv.setMethodIndex(aux);
		classEnv.setMethodCount(classEnv.getMethodCount() + 1);
		
		methods.put(methodEnv.getNameMethod(), methodEnv);
		
		return null;
	}
	
	public LlvmValue visit(IdentifierType n){
		if (classes.containsKey(n.name)) {
			return new LlvmNamedValue("%class."+n.name, classes.get(n.name));
		} else {
			ClassNode temp = new ClassNode(n.name, null, null);
			return new LlvmNamedValue("%class."+n.name, temp);
		}
	}
	
	public LlvmValue visit(IntArrayType n){
		return new LlvmNamedValue("i32 *", new LlvmPointer(LlvmPrimitiveType.I32));
	}
	
	public LlvmValue visit(BooleanType n){
		return new LlvmNamedValue("i1", LlvmPrimitiveType.I1);
	}
	
	public LlvmValue visit(IntegerType n){
		return new LlvmNamedValue("i32", LlvmPrimitiveType.I32);
	}
}

class ClassNode extends LlvmType {
	
	private String nameClass;
	private LlvmStructure classType;
	private List<LlvmValue> varList;
	private int methodCount;
	private Map<Integer, MethodNode> methodIndex;	// Usage: give method #, get method's node
	private ClassNode superClass;
	
	public ClassNode (String nameClass, LlvmStructure classType, List<LlvmValue> varList){
		this.setNameClass(nameClass);
		this.setClassType(classType);
		this.setVarList(varList);
		this.setMethodCount(0);
		this.setMethodIndex(new HashMap<Integer, MethodNode>());
	}

	public String getNameClass() {
		return nameClass;
	}

	public void setNameClass(String nameClass) {
		this.nameClass = nameClass;
	}

	public LlvmStructure getClassType() {
		return classType;
	}

	public void setClassType(LlvmStructure classType) {
		this.classType = classType;
	}

	public List<LlvmValue> getVarList() {
		return varList;
	}

	public void setVarList(List<LlvmValue> varList) {
		this.varList = varList;
	}

	public int getMethodCount() {
		return methodCount;
	}

	public void setMethodCount(int methodCount) {
		this.methodCount = methodCount;
	}

	public Map<Integer, MethodNode> getMethodIndex() {
		return methodIndex;
	}

	public void setMethodIndex(Map<Integer, MethodNode> methodIndex) {
		this.methodIndex = methodIndex;
	}

	public ClassNode getSuperClass() {
		return superClass;
	}

	public void setSuperClass(ClassNode superClass) {
		this.superClass = superClass;
	}
	
	public String toString() {
		return "%class." + this.nameClass;
	}
	
}

class MethodNode {
	
	private String nameMethod;
	private List<LlvmValue> formalList;
	private List<LlvmValue> localList;
	private LlvmType methodType;
	
	public MethodNode(String nameMethod, List<LlvmValue> formalList, List<LlvmValue> localList){
		this.setNameMethod(nameMethod);
		this.setFormalList(formalList);
		this.setLocalList(localList);
	}

	public String getNameMethod() {
		return nameMethod;
	}

	public void setNameMethod(String nameMethod) {
		this.nameMethod = nameMethod;
	}

	public List<LlvmValue> getFormalList() {
		return formalList;
	}

	public void setFormalList(List<LlvmValue> formalList) {
		this.formalList = formalList;
	}

	public List<LlvmValue> getLocalList() {
		return localList;
	}

	public void setLocalList(List<LlvmValue> localList) {
		this.localList = localList;
	}

	public LlvmType getMethodType() {
		return methodType;
	}

	public void setMethodType(LlvmType methodType) {
		this.methodType = methodType;
	}
	
}




