@.formatting.string = private constant [4 x i8] c"%d\0A\00"
m309 = { }
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
%class.teste = type { [2 x i8 *], i1, i32 * }
define i1 @__c_teste(i1 x, i32 y) {
define i1 @__d_teste() {
declare i32 @printf (i8 *, ...)
declare i8 * @malloc (i32)
