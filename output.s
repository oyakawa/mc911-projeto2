@.formatting.string = private constant [4 x i8] c"%d\0A\00"
%class.m309 = type { }
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
%class.teste1 = type { i32 }
define %class.teste1 * @__teste1_teste1(%class.teste1 * %this) {
entry0:
  ret %class.teste1 * %this
}
%class.teste2 = type { [1 x i8 *], i1 }
define i1 @__m_teste2() {
entry1:
  %t = alloca i8 *
  %i = alloca i32
  %tmp9 = call i8 *  @malloc(i32 12)
  %tmp10 = bitcast i8 * %tmp9 to %class.teste1 *
  %tmp8 = call %class.teste1 *  @__teste1_teste1(%class.teste1 * %tmp10)
  store %class.teste1 %tmp8, %class.teste1 * %t
  store i1 false, i1 * %b
  ret i1 true
}
define %class.teste2 * @__teste2_teste2(%class.teste2 * %this) {
entry2:
  ret %class.teste2 * %this
}
declare i32 @printf (i8 *, ...)
declare i8 * @malloc (i32)
