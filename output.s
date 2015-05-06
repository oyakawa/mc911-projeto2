@.formatting.string = private constant [4 x i8] c"%d\0A\00"
%class.m337 = type { }
define i32 @main() {
entry:
  %tmp0 = alloca i32
  store i32 0, i32 * %tmp0
  %tmp3 = call i8 *  @malloc(i32 8)
  %tmp4 = bitcast i8 * %tmp3 to %class.a *
  %tmp2 = call %class.a *  @__aConstructor_a(%class.a * %tmp4)
  %tmp1 = call i32  @__i_a(%class.a * %tmp2)
  %tmp5 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp6 = call i32 (i8 *, ...)* @printf(i8 * %tmp5, i32 %tmp1)
  %tmp7 = load i32 * %tmp0
  ret i32 %tmp7
}
%class.a = type { [2 x i8 *] }
define %class.a @__A_a(%class.a * %this) {
entry0:
  %tmp8 = call i8 *  @__A_a(%class.a * %this)
  ret i8 * %tmp8
}
define i32 @__i_a(%class.a * %this) {
entry1:
  ret i32 0
}
define %class.a * @__aConstructor_a(%class.a * %this) {
entry2:
  ret %class.a * %this
}
declare i32 @printf (i8 *, ...)
declare i8 * @malloc (i32)
