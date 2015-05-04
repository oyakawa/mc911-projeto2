@.formatting.string = private constant [4 x i8] c"%d\0A\00"
%class.m309 = { }
define i32 @main() {
entry:
  %tmp0 = alloca i32
  store i32 0, i32 * %tmp0
  br i1 true, label %ifThen0, label %ifElse0
ifThen0:
  %tmp1 = mul i32 10, 2
  %tmp2 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp3 = call i32 (i8 *, ...)* @printf(i8 * %tmp2, i32 %tmp1)
  %tmp4 = add i32 10, 3
  %tmp5 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp6 = call i32 (i8 *, ...)* @printf(i8 * %tmp5, i32 %tmp4)
  %tmp7 = mul i32 10, 4
  %tmp8 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp9 = call i32 (i8 *, ...)* @printf(i8 * %tmp8, i32 %tmp7)
  br label %ifEnd0
ifElse0:
  %tmp10 = sub i32 10, 2
  %tmp11 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp12 = call i32 (i8 *, ...)* @printf(i8 * %tmp11, i32 %tmp10)
  br label %ifEnd0
ifEnd0:
  %tmp13 = load i32 * %tmp0
  ret i32 %tmp13
}
%class.teste = type { [3 x i8 *], i1, i32 * }
define i1 @__c_teste(i1 %x, i32 %y) {
entry0:
  %x_tmp = alloca i1
  store i1 %x, i1 * %x_tmp
  %y_tmp = alloca i32
  store i32 %y, i32 * %y_tmp
  %tmp14 = mul i32 10, 3
  %tmp15 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp16 = call i32 (i8 *, ...)* @printf(i8 * %tmp15, i32 %tmp14)
  ret i32 1
}
define i1 @__d_teste() {
entry1:
  %e = alloca i1
  store i1 false, i1 * %e
  ret i1 false
}
define i1 @__e_teste() {
entry2:
  %z = alloca i32 *
  %tmp17 = alloca i32, i32 2
  store i32 * %tmp17, i32 * * %z
  ret i1 false
}
define void @__teste_teste(%class.teste * %this) {
entry3:
  ret void 
}
%class.feriado = type { [1 x i8 *] }
define i1 @__init_feriado() {
entry4:
  %tmp18 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp19 = call i32 (i8 *, ...)* @printf(i8 * %tmp18, i32 2)
  ret i1 true
}
define void @__feriado_feriado(%class.feriado * %this) {
entry5:
  %tmp20 = bitcast %class.feriado * %this to %class.teste *
  ret void 
}
declare i32 @printf (i8 *, ...)
declare i8 * @malloc (i32)
