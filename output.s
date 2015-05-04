@.formatting.string = private constant [4 x i8] c"%d\0A\00"
%class.m309 = { }
define i32 @main() {
entry:
  %tmp0 = alloca i32
  store i32 0, i32 * %tmp0
  br i1 true, label %ifThen0, label %ifElse0
ifThen0:
  %tmp1 = mul i32 10, 4
  %tmp2 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp3 = call i32 (i8 *, ...)* @printf(i8 * %tmp2, i32 %tmp1)
  br label %ifEnd0
ifElse0:
  %tmp4 = sub i32 10, 2
  %tmp5 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp6 = call i32 (i8 *, ...)* @printf(i8 * %tmp5, i32 %tmp4)
  br label %ifEnd0
ifEnd0:
  %tmp7 = load i32 * %tmp0
  ret i32 %tmp7
}
%class.teste = type { [3 x i8 *], %class.teste, i32 * }
define i32 @__c_teste(i1 %x, i32 %y) {
entry0:
  %x_tmp = alloca i1
  store i1 %x, i1 * %x_tmp
  %y_tmp = alloca i32
  store i32 %y, i32 * %y_tmp
  %tmp9 = call i8 *  @malloc(i32 16)
  %tmp10 = bitcast i8 * %tmp9 to %class.teste *
  %tmp8 = call %class.teste *  @__teste_teste(%class.teste * %tmp10)
  store i8 * %tmp8, i8 * * %a
  %tmp11 = mul i32 10, 3
  %tmp12 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp13 = call i32 (i8 *, ...)* @printf(i8 * %tmp12, i32 %tmp11)
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
  %tmp14 = alloca i32, i32 2
  store i32 * %tmp14, i32 * * %z
  ret i1 false
}
define %class.teste * @__teste_teste(%class.teste * %this) {
entry3:
  ret %class.teste * %this
}
%class.feriado = type { [1 x i8 *] }
define i1 @__init_feriado() {
entry4:
  %tmp15 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp16 = call i32 (i8 *, ...)* @printf(i8 * %tmp15, i32 2)
  ret i1 true
}
define %class.feriado * @__feriado_feriado(%class.feriado * %this) {
entry5:
  %tmp17 = bitcast %class.feriado * %this to %class.teste *
  ret void 
}
declare i32 @printf (i8 *, ...)
declare i8 * @malloc (i32)
