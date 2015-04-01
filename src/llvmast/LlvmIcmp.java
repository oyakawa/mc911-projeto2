package llvmast;
public  class LlvmIcmp extends LlvmInstruction{
	
	public LlvmRegister lhs;
	public String conditionCode;
    public LlvmType type;
    public LlvmValue op1, op2;
    
    public LlvmIcmp(LlvmRegister lhs,  int conditionCode, LlvmType type, LlvmValue op1, LlvmValue op2){
    	this.lhs = lhs;
		switch(conditionCode) {
			case(1):
				this.conditionCode = "eq";
				break;
			case(2):
				this.conditionCode = "ne";
				break;
			case(3):
				this.conditionCode = "ugt";
				break;
			case(4):
				this.conditionCode = "uge";
				break;
			case(5):
				this.conditionCode = "ult";
				break;
			case(6):
				this.conditionCode = "ule";
				break;
			case(7):
				this.conditionCode = "sgt";
				break;
			case(8):
				this.conditionCode = "sge";
				break;
			case(9):
				this.conditionCode = "slt";
				break;
			case(10):
				this.conditionCode = "sle";
				break;
			default:
				break;
		}
    	this.type = type;
		this.op1 = op1;
		this.op2 = op2;
    }

    public String toString(){
    	return "  " +lhs + " = icmp " + conditionCode + " " + type + " " + op1 + ", " + op2;
    }
}