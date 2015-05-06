@.formatting.string = private constant [4 x i8] c"%d\0A\00"
%class.Factorial = type { }
define i32 @main() {
entry:
  %tmp0 = alloca i32
  store i32 0, i32 * %tmp0
  %tmp3 = call i8 *  @malloc(i32 8)
  %tmp4 = bitcast i8 * %tmp3 to %class.Fac *
  %tmp2 = call %class.Fac *  @__FacConstructor_Fac(%class.Fac * %tmp4)
  %tmp1 = call i32  @__ComputeFac_Fac(%class.Fac * %tmp2, i32 10)
  %tmp5 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp6 = call i32 (i8 *, ...)* @printf(i8 * %tmp5, i32 %tmp1)
  %tmp7 = load i32 * %tmp0
  ret i32 %tmp7
}
%class.Fac = type { [1 x i8 *] }
define i32 @__ComputeFac_Fac(%class.Fac * %this, i32 %num) {
entry0:
  %num_tmp = alloca i32
  store i32 %num, i32 * %num_tmp
  %num_aux = alloca i32
  %tmp8 = load i32 * %num_tmp
  %tmp9 = icmp slt i32 %tmp8, 1
  br i1 %tmp9, label %ifThen0, label %ifElse0
ifThen0:
  store i32 1, i32 * %num_aux
  br label %ifEnd0
ifElse0:
  %tmp10 = load i32 * %num_tmp
  %tmp12 = load %class.Fac * %this
  %tmp13 = load i32 * %num_tmp
  %tmp14 = sub i32 %tmp13, 1
  %tmp11 = call i32  @__ComputeFac_Fac(%class.Fac %tmp12, i32 %tmp14)
  %tmp15 = mul i32 %tmp10, %tmp11
  store i32 %tmp15, i32 * %num_aux
  br label %ifEnd0
ifEnd0:
  %tmp16 = load i32 * %num_aux
  ret i32 %tmp16
}
define %class.Fac * @__FacConstructor_Fac(%class.Fac * %this) {
entry1:
  ret %class.Fac * %this
}
declare i32 @printf (i8 *, ...)
declare i8 * @malloc (i32)
