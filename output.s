@.formatting.string = private constant [4 x i8] c"%d\0A\00"
%class.m309 = type { }
define i32 @main() {
entry:
  %tmp0 = alloca i32
  store i32 0, i32 * %tmp0
  br i1 true, label %ifThen0, label %ifElse0
ifThen0:
  %tmp3 = call i8 *  @malloc(i32 12)
  %tmp4 = bitcast i8 * %tmp3 to %class.teste2 *
  %tmp2 = call %class.teste2 *  @__teste2_teste2(%class.teste2 * %tmp4)
  %tmp1 = call i32  @__m_teste2(%class.teste2 * %tmp2, i32 10)
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
%class.teste1 = type { i32 }
define %class.teste1 * @__teste1_teste1(%class.teste1 * %this) {
entry0:
  ret %class.teste1 * %this
}
%class.teste2 = type { [2 x i8 *], i32 }
define i32 @__m_teste2(%class.teste2 * %this, i32 %x) {
entry1:
  %x_tmp = alloca i32
  store i32 %x, i32 * %x_tmp
  %tmp11 = getelementptr %class.teste2 * %this, i32 0, i32 1
  store i32 10, i32 * %tmp11
  %tmp12 = getelementptr %class.teste2 * %this, i32 0, i32 1
  %tmp13 = load i32 * %tmp12
  ret i32 %tmp13
}
define i1 @__n_teste2(%class.teste2 * %this) {
entry2:
  ret i1 false
}
define %class.teste2 * @__teste2_teste2(%class.teste2 * %this) {
entry3:
  ret %class.teste2 * %this
}
declare i32 @printf (i8 *, ...)
declare i8 * @malloc (i32)
