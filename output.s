@.formatting.string = private constant [4 x i8] c"%d\0A\00"
%class.mteste = type { }
define i32 @main() {
entry:
  %tmp0 = alloca i32
  store i32 0, i32 * %tmp0
  br i1 true, label %ifThen0, label %ifElse0
ifThen0:
  %tmp3 = call i8 *  @malloc(i32 16)
  %tmp4 = bitcast i8 * %tmp3 to %class.teste *
  %tmp2 = call %class.teste *  @__testeConstructor_teste(%class.teste * %tmp4)
  %tmp1 = call i32  @__c_teste(%class.teste * %tmp2, i1 true, i32 3)
  %tmp5 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp6 = call i32 (i8 *, ...)* @printf(i8 * %tmp5, i32 %tmp1)
  br label %ifEnd0
ifElse0:
  %tmp7 = sub i32 10, 2
  %tmp8 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp9 = call i32 (i8 *, ...)* @printf(i8 * %tmp8, i32 %tmp7)
  br label %ifEnd0
ifEnd0:
  %tmp10 = load i32 * %tmp0
  ret i32 %tmp10
}
%class.teste = type { [1 x i8 *], i32 * }
define i32 @__c_teste(%class.teste * %this, i1 %x, i32 %y) {
entry0:
  %x_tmp = alloca i1
  store i1 %x, i1 * %x_tmp
  %y_tmp = alloca i32
  store i32 %y, i32 * %y_tmp
  %tmp11 = getelementptr %class.teste * %this, i32 0, i32 1
  %tmp13 = add i32 10, 1
  %tmp14 = mul i32 4, %tmp13
  %tmp15 = call i8* @malloc ( i32 %tmp14)
  %tmp12 = bitcast i8* %tmp15 to i32*
  store i32 10, i32 * %tmp12
  store i32 * %tmp12, i32 * * %tmp11
  %tmp16 = getelementptr %class.teste * %this, i32 0, i32 1
  %tmp17 = load i32 * * %tmp16
  %tmp18 = getelementptr i32 * * %tmp17, i32 0
  %tmp19 = load i32 * %tmp18
  %tmp20 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp21 = call i32 (i8 *, ...)* @printf(i8 * %tmp20, i32 %tmp19)
  ret i32 1
}
define %class.teste * @__testeConstructor_teste(%class.teste * %this) {
entry1:
  ret %class.teste * %this
}
declare i32 @printf (i8 *, ...)
declare i8 * @malloc (i32)
