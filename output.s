@.formatting.string = private constant [4 x i8] c"%d\0A\00"
<<<<<<< Updated upstream
%class.mteste = type { }
=======
%class.BinaryTree = type { }
>>>>>>> Stashed changes
define i32 @main() {
entry:
  %tmp0 = alloca i32
  store i32 0, i32 * %tmp0
<<<<<<< Updated upstream
  br i1 true, label %ifThen0, label %ifElse0
ifThen0:
  %tmp3 = call i8 *  @malloc(i32 16)
  %tmp4 = bitcast i8 * %tmp3 to %class.teste *
  %tmp2 = call %class.teste *  @__testeConstructor_teste(%class.teste * %tmp4)
  %tmp1 = call i32  @__c_teste(%class.teste * %tmp2, i1 true, i32 3)
=======
  %tmp3 = call i8 *  @malloc(i32 8)
  %tmp4 = bitcast i8 * %tmp3 to %class.BT *
  %tmp2 = call %class.BT *  @__BTConstructor_BT(%class.BT * %tmp4)
  %tmp1 = call i32  @__Start_BT(%class.BT * %tmp2)
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
  %tmp18 = getelementptr i32 %tmp17, i32 0
  %tmp19 = load i32 * %tmp18
  %tmp20 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp21 = call i32 (i8 *, ...)* @printf(i8 * %tmp20, i32 %tmp19)
  ret i32 1
}
define %class.teste * @__testeConstructor_teste(%class.teste * %this) {
entry1:
  ret %class.teste * %this
=======
%class.BT = type { [1 x i8 *] }
define i32 @__Start_BT(%class.BT * %this) {
entry0:
  %root = alloca %class.Tree
  %ntb = alloca i1
  %nti = alloca i32
  %tmp9 = call i8 *  @malloc(i32 14)
  %tmp10 = bitcast i8 * %tmp9 to %class.Tree *
  %tmp8 = call %class.Tree *  @__TreeConstructor_Tree(%class.Tree * %tmp10)
  store %class.Tree * %tmp8, %class.Tree * %root
  %tmp12 = load %class.Tree * %root
  %tmp11 = call i1  @__Init_Tree(i32 %tmp12, i32 16)
  store i1 %tmp11, i1 * %ntb
  %tmp14 = load %class.Tree * %root
  %tmp13 = call i1  @__Print_Tree(i32 %tmp14)
  store i1 %tmp13, i1 * %ntb
  %tmp15 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp16 = call i32 (i8 *, ...)* @printf(i8 * %tmp15, i32 100000000)
  %tmp18 = load %class.Tree * %root
  %tmp17 = call i1  @__Insert_Tree(i32 %tmp18, i32 8)
  store i1 %tmp17, i1 * %ntb
  %tmp20 = load %class.Tree * %root
  %tmp19 = call i1  @__Print_Tree(i32 %tmp20)
  store i1 %tmp19, i1 * %ntb
  %tmp22 = load %class.Tree * %root
  %tmp21 = call i1  @__Insert_Tree(i32 %tmp22, i32 24)
  store i1 %tmp21, i1 * %ntb
  %tmp24 = load %class.Tree * %root
  %tmp23 = call i1  @__Insert_Tree(i32 %tmp24, i32 4)
  store i1 %tmp23, i1 * %ntb
  %tmp26 = load %class.Tree * %root
  %tmp25 = call i1  @__Insert_Tree(i32 %tmp26, i32 12)
  store i1 %tmp25, i1 * %ntb
  %tmp28 = load %class.Tree * %root
  %tmp27 = call i1  @__Insert_Tree(i32 %tmp28, i32 20)
  store i1 %tmp27, i1 * %ntb
  %tmp30 = load %class.Tree * %root
  %tmp29 = call i1  @__Insert_Tree(i32 %tmp30, i32 28)
  store i1 %tmp29, i1 * %ntb
  %tmp32 = load %class.Tree * %root
  %tmp31 = call i1  @__Insert_Tree(i32 %tmp32, i32 14)
  store i1 %tmp31, i1 * %ntb
  %tmp34 = load %class.Tree * %root
  %tmp33 = call i1  @__Print_Tree(i32 %tmp34)
  store i1 %tmp33, i1 * %ntb
  %tmp36 = load %class.Tree * %root
  %tmp35 = call i32  @__Search_Tree(i32 %tmp36, i32 24)
  %tmp37 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp38 = call i32 (i8 *, ...)* @printf(i8 * %tmp37, i32 %tmp35)
  %tmp40 = load %class.Tree * %root
  %tmp39 = call i32  @__Search_Tree(i32 %tmp40, i32 12)
  %tmp41 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp42 = call i32 (i8 *, ...)* @printf(i8 * %tmp41, i32 %tmp39)
  %tmp44 = load %class.Tree * %root
  %tmp43 = call i32  @__Search_Tree(i32 %tmp44, i32 16)
  %tmp45 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp46 = call i32 (i8 *, ...)* @printf(i8 * %tmp45, i32 %tmp43)
  %tmp48 = load %class.Tree * %root
  %tmp47 = call i32  @__Search_Tree(i32 %tmp48, i32 50)
  %tmp49 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp50 = call i32 (i8 *, ...)* @printf(i8 * %tmp49, i32 %tmp47)
  %tmp52 = load %class.Tree * %root
  %tmp51 = call i32  @__Search_Tree(i32 %tmp52, i32 12)
  %tmp53 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp54 = call i32 (i8 *, ...)* @printf(i8 * %tmp53, i32 %tmp51)
  %tmp56 = load %class.Tree * %root
  %tmp55 = call i1  @__Delete_Tree(i32 %tmp56, i32 12)
  store i1 %tmp55, i1 * %ntb
  %tmp58 = load %class.Tree * %root
  %tmp57 = call i1  @__Print_Tree(i32 %tmp58)
  store i1 %tmp57, i1 * %ntb
  %tmp60 = load %class.Tree * %root
  %tmp59 = call i32  @__Search_Tree(i32 %tmp60, i32 12)
  %tmp61 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp62 = call i32 (i8 *, ...)* @printf(i8 * %tmp61, i32 %tmp59)
  ret i32 0
}
define %class.BT * @__BTConstructor_BT(%class.BT * %this) {
entry1:
  ret %class.BT * %this
}
%class.Tree = type { [20 x i8 *], %class.Tree, %class.Tree, i32, i1, i1, %class.Tree }
define i1 @__Init_Tree(%class.Tree * %this, i32 %v_key) {
entry2:
  %v_key_tmp = alloca i32
  store i32 %v_key, i32 * %v_key_tmp
  %tmp63 = getelementptr %class.Tree * %this, i32 0, i32 3
  %tmp64 = load i32 * %v_key_tmp
  store i1 %tmp64, i32 * %tmp63
  %tmp65 = getelementptr %class.Tree * %this, i32 0, i32 4
  store i1 false, i1 * %tmp65
  %tmp66 = getelementptr %class.Tree * %this, i32 0, i32 5
  store i1 false, i1 * %tmp66
  ret i1 true
}
define i1 @__SetRight_Tree(%class.Tree * %this, %class.Tree %rn) {
entry3:
  %rn_tmp = alloca %class.Tree
  store %class.Tree %rn, %class.Tree * %rn_tmp
  %tmp67 = getelementptr %class.Tree * %this, i32 0, i32 2
  %tmp68 = load %class.Tree * %rn_tmp
  store i1 %tmp68, %class.Tree * %tmp67
  ret i1 true
}
define i1 @__SetLeft_Tree(%class.Tree * %this, %class.Tree %ln) {
entry4:
  %ln_tmp = alloca %class.Tree
  store %class.Tree %ln, %class.Tree * %ln_tmp
  %tmp69 = getelementptr %class.Tree * %this, i32 0, i32 1
  %tmp70 = load %class.Tree * %ln_tmp
  store i1 %tmp70, %class.Tree * %tmp69
  ret i1 true
}
define %class.Tree @__GetRight_Tree(%class.Tree * %this) {
entry5:
  %tmp71 = getelementptr %class.Tree * %this, i32 0, i32 2
  %tmp72 = load %class.Tree * %tmp71
  ret %class.Tree %tmp72
}
define %class.Tree @__GetLeft_Tree(%class.Tree * %this) {
entry6:
  %tmp73 = getelementptr %class.Tree * %this, i32 0, i32 1
  %tmp74 = load %class.Tree * %tmp73
  ret %class.Tree %tmp74
}
define i32 @__GetKey_Tree(%class.Tree * %this) {
entry7:
  %tmp75 = getelementptr %class.Tree * %this, i32 0, i32 3
  %tmp76 = load i32 * %tmp75
  ret i32 %tmp76
}
define i1 @__SetKey_Tree(%class.Tree * %this, i32 %v_key) {
entry8:
  %v_key_tmp = alloca i32
  store i32 %v_key, i32 * %v_key_tmp
  %tmp77 = getelementptr %class.Tree * %this, i32 0, i32 3
  %tmp78 = load i32 * %v_key_tmp
  store i1 %tmp78, i32 * %tmp77
  ret i1 true
}
define i1 @__GetHas_Right_Tree(%class.Tree * %this) {
entry9:
  %tmp79 = getelementptr %class.Tree * %this, i32 0, i32 5
  %tmp80 = load i1 * %tmp79
  ret i1 %tmp80
}
define i1 @__GetHas_Left_Tree(%class.Tree * %this) {
entry10:
  %tmp81 = getelementptr %class.Tree * %this, i32 0, i32 4
  %tmp82 = load i1 * %tmp81
  ret i1 %tmp82
}
define i1 @__SetHas_Left_Tree(%class.Tree * %this, i1 %val) {
entry11:
  %val_tmp = alloca i1
  store i1 %val, i1 * %val_tmp
  %tmp83 = getelementptr %class.Tree * %this, i32 0, i32 4
  %tmp84 = load i1 * %val_tmp
  store i1 %tmp84, i1 * %tmp83
  ret i1 true
}
define i1 @__SetHas_Right_Tree(%class.Tree * %this, i1 %val) {
entry12:
  %val_tmp = alloca i1
  store i1 %val, i1 * %val_tmp
  %tmp85 = getelementptr %class.Tree * %this, i32 0, i32 5
  %tmp86 = load i1 * %val_tmp
  store i1 %tmp86, i1 * %tmp85
  ret i1 true
}
define i1 @__Compare_Tree(%class.Tree * %this, i32 %num1, i32 %num2) {
entry13:
  %num1_tmp = alloca i32
  store i32 %num1, i32 * %num1_tmp
  %num2_tmp = alloca i32
  store i32 %num2, i32 * %num2_tmp
  %ntb = alloca i1
  %nti = alloca i32
  store i1 false, i1 * %ntb
  %tmp87 = load i32 * %num2_tmp
  %tmp88 = add i32 %tmp87, 1
  store i32 %tmp88, i32 * %nti
  %tmp89 = load i32 * %num1_tmp
  %tmp90 = load i32 * %num2_tmp
  %tmp91 = icmp slt i32 %tmp89, %tmp90
  br i1 %tmp91, label %ifThen0, label %ifElse0
ifThen0:
  store i1 false, i1 * %ntb
  br label %ifEnd0
ifElse0:
  %tmp92 = load i32 * %num1_tmp
  %tmp93 = load i32 * %nti
  %tmp94 = icmp slt i32 %tmp92, %tmp93
  br i1 true, label %ifThen1, label %ifElse1
ifThen1:
  store i1 false, i1 * %ntb
  br label %ifEnd1
ifElse1:
  store i1 true, i1 * %ntb
  br label %ifEnd1
ifEnd1:
  br label %ifEnd0
ifEnd0:
  %tmp95 = load i1 * %ntb
  ret i1 %tmp95
}
define i1 @__Insert_Tree(%class.Tree * %this, i32 %v_key) {
entry14:
  %v_key_tmp = alloca i32
  store i32 %v_key, i32 * %v_key_tmp
  %new_node = alloca %class.Tree
  %ntb = alloca i1
  %cont = alloca i1
  %key_aux = alloca i32
  %current_node = alloca %class.Tree
  %tmp97 = call i8 *  @malloc(i32 14)
  %tmp98 = bitcast i8 * %tmp97 to %class.Tree *
  %tmp96 = call %class.Tree *  @__TreeConstructor_Tree(%class.Tree * %tmp98)
  store %class.Tree * %tmp96, %class.Tree * %new_node
  %tmp100 = load %class.Tree * %new_node
  %tmp101 = load i32 * %v_key_tmp
  %tmp99 = call i1  @__Init_Tree(i1 %tmp100, i1 %tmp101)
  store i1 %tmp99, i1 * %ntb
  %tmp102 = load %class.Tree * %this
  store %class.Tree %tmp102, %class.Tree * %current_node
  store i1 true, i1 * %cont
whileCond0:
  %tmp103 = load i1 * %cont
  br i1 %tmp103, label %whileBody0, label %whileEnd0
whileBody0:
  %tmp105 = load %class.Tree * %current_node
  %tmp104 = call i32  @__GetKey_Tree(i1 %tmp105)
  store i32 %tmp104, i32 * %key_aux
  %tmp106 = load i32 * %v_key_tmp
  %tmp107 = load i32 * %key_aux
  %tmp108 = icmp slt i32 %tmp106, %tmp107
  br i1 %tmp108, label %ifThen2, label %ifElse2
ifThen2:
  %tmp110 = load %class.Tree * %current_node
  %tmp109 = call i1  @__GetHas_Left_Tree(i1 %tmp110)
  br i1 %tmp109, label %ifThen3, label %ifElse3
ifThen3:
  %tmp112 = load %class.Tree * %current_node
  %tmp111 = call %class.Tree  @__GetLeft_Tree(i1 %tmp112)
  store %class.Tree %tmp111, %class.Tree * %current_node
  br label %ifEnd3
ifElse3:
  store i1 false, i1 * %cont
  %tmp114 = load %class.Tree * %current_node
  %tmp113 = call i1  @__SetHas_Left_Tree(i1 %tmp114, i1 true)
  store i1 %tmp113, i1 * %ntb
  %tmp116 = load %class.Tree * %current_node
  %tmp117 = load %class.Tree * %new_node
  %tmp115 = call i1  @__SetLeft_Tree(i1 %tmp116, i1 %tmp117)
  store i1 %tmp115, i1 * %ntb
  br label %ifEnd3
ifEnd3:
  br label %ifEnd2
ifElse2:
  %tmp119 = load %class.Tree * %current_node
  %tmp118 = call i1  @__GetHas_Right_Tree(i1 %tmp119)
  br i1 %tmp118, label %ifThen4, label %ifElse4
ifThen4:
  %tmp121 = load %class.Tree * %current_node
  %tmp120 = call %class.Tree  @__GetRight_Tree(i1 %tmp121)
  store %class.Tree %tmp120, %class.Tree * %current_node
  br label %ifEnd4
ifElse4:
  store i1 false, i1 * %cont
  %tmp123 = load %class.Tree * %current_node
  %tmp122 = call i1  @__SetHas_Right_Tree(i1 %tmp123, i1 true)
  store i1 %tmp122, i1 * %ntb
  %tmp125 = load %class.Tree * %current_node
  %tmp126 = load %class.Tree * %new_node
  %tmp124 = call i1  @__SetRight_Tree(i1 %tmp125, i1 %tmp126)
  store i1 %tmp124, i1 * %ntb
  br label %ifEnd4
ifEnd4:
  br label %ifEnd2
ifEnd2:
  br label %whileCond0
whileEnd0:
  ret i1 true
}
define i1 @__Delete_Tree(%class.Tree * %this, i32 %v_key) {
entry15:
  %v_key_tmp = alloca i32
  store i32 %v_key, i32 * %v_key_tmp
  %current_node = alloca %class.Tree
  %parent_node = alloca %class.Tree
  %cont = alloca i1
  %found = alloca i1
  %is_root = alloca i1
  %key_aux = alloca i32
  %ntb = alloca i1
  %tmp127 = load %class.Tree * %this
  store %class.Tree %tmp127, %class.Tree * %current_node
  %tmp128 = load %class.Tree * %this
  store %class.Tree %tmp128, %class.Tree * %parent_node
  store i1 true, i1 * %cont
  store i1 false, i1 * %found
  store i1 true, i1 * %is_root
whileCond1:
  %tmp129 = load i1 * %cont
  br i1 %tmp129, label %whileBody1, label %whileEnd1
whileBody1:
  %tmp131 = load %class.Tree * %current_node
  %tmp130 = call i32  @__GetKey_Tree(i1 %tmp131)
  store i32 %tmp130, i32 * %key_aux
  %tmp132 = load i32 * %v_key_tmp
  %tmp133 = load i32 * %key_aux
  %tmp134 = icmp slt i32 %tmp132, %tmp133
  br i1 %tmp134, label %ifThen5, label %ifElse5
ifThen5:
  %tmp136 = load %class.Tree * %current_node
  %tmp135 = call i1  @__GetHas_Left_Tree(i1 %tmp136)
  br i1 %tmp135, label %ifThen6, label %ifElse6
ifThen6:
  %tmp137 = load %class.Tree * %current_node
  store i1 %tmp137, %class.Tree * %parent_node
  %tmp139 = load %class.Tree * %current_node
  %tmp138 = call %class.Tree  @__GetLeft_Tree(i1 %tmp139)
  store %class.Tree %tmp138, %class.Tree * %current_node
  br label %ifEnd6
ifElse6:
  store i1 false, i1 * %cont
  br label %ifEnd6
ifEnd6:
  br label %ifEnd5
ifElse5:
  %tmp140 = load i32 * %key_aux
  %tmp141 = load i32 * %v_key_tmp
  %tmp142 = icmp slt i32 %tmp140, %tmp141
  br i1 %tmp142, label %ifThen7, label %ifElse7
ifThen7:
  %tmp144 = load %class.Tree * %current_node
  %tmp143 = call i1  @__GetHas_Right_Tree(i1 %tmp144)
  br i1 %tmp143, label %ifThen8, label %ifElse8
ifThen8:
  %tmp145 = load %class.Tree * %current_node
  store i1 %tmp145, %class.Tree * %parent_node
  %tmp147 = load %class.Tree * %current_node
  %tmp146 = call %class.Tree  @__GetRight_Tree(i1 %tmp147)
  store %class.Tree %tmp146, %class.Tree * %current_node
  br label %ifEnd8
ifElse8:
  store i1 false, i1 * %cont
  br label %ifEnd8
ifEnd8:
  br label %ifEnd7
ifElse7:
  %tmp148 = load i1 * %is_root
  br i1 %tmp148, label %ifThen9, label %ifElse9
ifThen9:
  %tmp150 = load %class.Tree * %current_node
  %tmp149 = call i1  @__GetHas_Right_Tree(i1 %tmp150)
  %tmp152 = load %class.Tree * %current_node
  %tmp151 = call i1  @__GetHas_Left_Tree(i1 %tmp152)
  %tmp153 = mul i1 true, true
  %tmp154 = icmp ne i1 %tmp153, 0
  br i1 %tmp154, label %ifThen10, label %ifElse10
ifThen10:
  store i1 true, i1 * %ntb
  br label %ifEnd10
ifElse10:
  %tmp156 = load %class.Tree * %parent_node
  %tmp157 = load %class.Tree * %current_node
  %tmp155 = call i1  @__Remove_Tree(%class.Tree * %this, i1 %tmp156, i1 %tmp157)
  store i1 %tmp155, i1 * %ntb
  br label %ifEnd10
ifEnd10:
  br label %ifEnd9
ifElse9:
  %tmp159 = load %class.Tree * %parent_node
  %tmp160 = load %class.Tree * %current_node
  %tmp158 = call i1  @__Remove_Tree(%class.Tree * %this, i1 %tmp159, i1 %tmp160)
  store i1 %tmp158, i1 * %ntb
  br label %ifEnd9
ifEnd9:
  store i1 true, i1 * %found
  store i1 false, i1 * %cont
  br label %ifEnd7
ifEnd7:
  br label %ifEnd5
ifEnd5:
  store i1 false, i1 * %is_root
  br label %whileCond1
whileEnd1:
  %tmp161 = load i1 * %found
  ret i1 %tmp161
}
define i1 @__Remove_Tree(%class.Tree * %this, %class.Tree %p_node, %class.Tree %c_node) {
entry16:
  %p_node_tmp = alloca %class.Tree
  store %class.Tree %p_node, %class.Tree * %p_node_tmp
  %c_node_tmp = alloca %class.Tree
  store %class.Tree %c_node, %class.Tree * %c_node_tmp
  %ntb = alloca i1
  %auxkey1 = alloca i32
  %auxkey2 = alloca i32
  %tmp163 = load %class.Tree * %c_node_tmp
  %tmp162 = call i1  @__GetHas_Left_Tree(i1 %tmp163)
  br i1 %tmp162, label %ifThen11, label %ifElse11
ifThen11:
  %tmp165 = load %class.Tree * %p_node_tmp
  %tmp166 = load %class.Tree * %c_node_tmp
  %tmp164 = call i1  @__RemoveLeft_Tree(%class.Tree * %this, i1 %tmp165, i1 %tmp166)
  store i1 %tmp164, i1 * %ntb
  br label %ifEnd11
ifElse11:
  %tmp168 = load %class.Tree * %c_node_tmp
  %tmp167 = call i1  @__GetHas_Right_Tree(i1 %tmp168)
  br i1 %tmp167, label %ifThen12, label %ifElse12
ifThen12:
  %tmp170 = load %class.Tree * %p_node_tmp
  %tmp171 = load %class.Tree * %c_node_tmp
  %tmp169 = call i1  @__RemoveRight_Tree(%class.Tree * %this, i1 %tmp170, i1 %tmp171)
  store i1 %tmp169, i1 * %ntb
  br label %ifEnd12
ifElse12:
  %tmp173 = load %class.Tree * %c_node_tmp
  %tmp172 = call i32  @__GetKey_Tree(i1 %tmp173)
  store i32 %tmp172, i32 * %auxkey1
  %tmp176 = load %class.Tree * %p_node_tmp
  %tmp175 = call %class.Tree  @__GetLeft_Tree(i1 %tmp176)
  %tmp174 = call i32  @__GetKey_Tree(%class.Tree %tmp175)
  store i32 %tmp174, i32 * %auxkey2
  %tmp178 = load i32 * %auxkey1
  %tmp179 = load i32 * %auxkey2
  %tmp177 = call i1  @__Compare_Tree(%class.Tree * %this, i1 %tmp178, i1 %tmp179)
  br i1 %tmp177, label %ifThen13, label %ifElse13
ifThen13:
  %tmp181 = load %class.Tree * %p_node_tmp
  %tmp182 = getelementptr %class.Tree * %this, i32 0, i32 6
  %tmp183 = load %class.Tree * %tmp182
  %tmp180 = call i1  @__SetLeft_Tree(i1 %tmp181, i1 %tmp183)
  store i1 %tmp180, i1 * %ntb
  %tmp185 = load %class.Tree * %p_node_tmp
  %tmp184 = call i1  @__SetHas_Left_Tree(i1 %tmp185, i1 false)
  store i1 %tmp184, i1 * %ntb
  br label %ifEnd13
ifElse13:
  %tmp187 = load %class.Tree * %p_node_tmp
  %tmp188 = getelementptr %class.Tree * %this, i32 0, i32 6
  %tmp189 = load %class.Tree * %tmp188
  %tmp186 = call i1  @__SetRight_Tree(i1 %tmp187, i1 %tmp189)
  store i1 %tmp186, i1 * %ntb
  %tmp191 = load %class.Tree * %p_node_tmp
  %tmp190 = call i1  @__SetHas_Right_Tree(i1 %tmp191, i1 false)
  store i1 %tmp190, i1 * %ntb
  br label %ifEnd13
ifEnd13:
  br label %ifEnd12
ifEnd12:
  br label %ifEnd11
ifEnd11:
  ret i1 true
}
define i1 @__RemoveRight_Tree(%class.Tree * %this, %class.Tree %p_node, %class.Tree %c_node) {
entry17:
  %p_node_tmp = alloca %class.Tree
  store %class.Tree %p_node, %class.Tree * %p_node_tmp
  %c_node_tmp = alloca %class.Tree
  store %class.Tree %c_node, %class.Tree * %c_node_tmp
  %ntb = alloca i1
whileCond2:
  %tmp193 = load %class.Tree * %c_node_tmp
  %tmp192 = call i1  @__GetHas_Right_Tree(i1 %tmp193)
  br i1 %tmp192, label %whileBody2, label %whileEnd2
whileBody2:
  %tmp195 = load %class.Tree * %c_node_tmp
  %tmp198 = load %class.Tree * %c_node_tmp
  %tmp197 = call %class.Tree  @__GetRight_Tree(i1 %tmp198)
  %tmp196 = call i32  @__GetKey_Tree(%class.Tree %tmp197)
  %tmp194 = call i1  @__SetKey_Tree(i1 %tmp195, i32 %tmp196)
  store i1 %tmp194, i1 * %ntb
  %tmp199 = load %class.Tree * %c_node_tmp
  store i1 %tmp199, %class.Tree * %p_node_tmp
  %tmp201 = load %class.Tree * %c_node_tmp
  %tmp200 = call %class.Tree  @__GetRight_Tree(i1 %tmp201)
  store %class.Tree %tmp200, %class.Tree * %c_node_tmp
  br label %whileCond2
whileEnd2:
  %tmp203 = load %class.Tree * %p_node_tmp
  %tmp204 = getelementptr %class.Tree * %this, i32 0, i32 6
  %tmp205 = load %class.Tree * %tmp204
  %tmp202 = call i1  @__SetRight_Tree(i1 %tmp203, i1 %tmp205)
  store i1 %tmp202, i1 * %ntb
  %tmp207 = load %class.Tree * %p_node_tmp
  %tmp206 = call i1  @__SetHas_Right_Tree(i1 %tmp207, i1 false)
  store i1 %tmp206, i1 * %ntb
  ret i1 true
}
define i1 @__RemoveLeft_Tree(%class.Tree * %this, %class.Tree %p_node, %class.Tree %c_node) {
entry18:
  %p_node_tmp = alloca %class.Tree
  store %class.Tree %p_node, %class.Tree * %p_node_tmp
  %c_node_tmp = alloca %class.Tree
  store %class.Tree %c_node, %class.Tree * %c_node_tmp
  %ntb = alloca i1
whileCond3:
  %tmp209 = load %class.Tree * %c_node_tmp
  %tmp208 = call i1  @__GetHas_Left_Tree(i1 %tmp209)
  br i1 %tmp208, label %whileBody3, label %whileEnd3
whileBody3:
  %tmp211 = load %class.Tree * %c_node_tmp
  %tmp214 = load %class.Tree * %c_node_tmp
  %tmp213 = call %class.Tree  @__GetLeft_Tree(i1 %tmp214)
  %tmp212 = call i32  @__GetKey_Tree(%class.Tree %tmp213)
  %tmp210 = call i1  @__SetKey_Tree(i1 %tmp211, i32 %tmp212)
  store i1 %tmp210, i1 * %ntb
  %tmp215 = load %class.Tree * %c_node_tmp
  store i1 %tmp215, %class.Tree * %p_node_tmp
  %tmp217 = load %class.Tree * %c_node_tmp
  %tmp216 = call %class.Tree  @__GetLeft_Tree(i1 %tmp217)
  store %class.Tree %tmp216, %class.Tree * %c_node_tmp
  br label %whileCond3
whileEnd3:
  %tmp219 = load %class.Tree * %p_node_tmp
  %tmp220 = getelementptr %class.Tree * %this, i32 0, i32 6
  %tmp221 = load %class.Tree * %tmp220
  %tmp218 = call i1  @__SetLeft_Tree(i1 %tmp219, i1 %tmp221)
  store i1 %tmp218, i1 * %ntb
  %tmp223 = load %class.Tree * %p_node_tmp
  %tmp222 = call i1  @__SetHas_Left_Tree(i1 %tmp223, i1 false)
  store i1 %tmp222, i1 * %ntb
  ret i1 true
}
define i32 @__Search_Tree(%class.Tree * %this, i32 %v_key) {
entry19:
  %v_key_tmp = alloca i32
  store i32 %v_key, i32 * %v_key_tmp
  %cont = alloca i1
  %ifound = alloca i32
  %current_node = alloca %class.Tree
  %key_aux = alloca i32
  %tmp224 = load %class.Tree * %this
  store %class.Tree %tmp224, %class.Tree * %current_node
  store i1 true, i1 * %cont
  store i32 0, i32 * %ifound
whileCond4:
  %tmp225 = load i1 * %cont
  br i1 %tmp225, label %whileBody4, label %whileEnd4
whileBody4:
  %tmp227 = load %class.Tree * %current_node
  %tmp226 = call i32  @__GetKey_Tree(i32 %tmp227)
  store i32 %tmp226, i32 * %key_aux
  %tmp228 = load i32 * %v_key_tmp
  %tmp229 = load i32 * %key_aux
  %tmp230 = icmp slt i32 %tmp228, %tmp229
  br i1 %tmp230, label %ifThen14, label %ifElse14
ifThen14:
  %tmp232 = load %class.Tree * %current_node
  %tmp231 = call i1  @__GetHas_Left_Tree(i32 %tmp232)
  br i1 %tmp231, label %ifThen15, label %ifElse15
ifThen15:
  %tmp234 = load %class.Tree * %current_node
  %tmp233 = call %class.Tree  @__GetLeft_Tree(i32 %tmp234)
  store %class.Tree %tmp233, %class.Tree * %current_node
  br label %ifEnd15
ifElse15:
  store i1 false, i1 * %cont
  br label %ifEnd15
ifEnd15:
  br label %ifEnd14
ifElse14:
  %tmp235 = load i32 * %key_aux
  %tmp236 = load i32 * %v_key_tmp
  %tmp237 = icmp slt i32 %tmp235, %tmp236
  br i1 %tmp237, label %ifThen16, label %ifElse16
ifThen16:
  %tmp239 = load %class.Tree * %current_node
  %tmp238 = call i1  @__GetHas_Right_Tree(i32 %tmp239)
  br i1 %tmp238, label %ifThen17, label %ifElse17
ifThen17:
  %tmp241 = load %class.Tree * %current_node
  %tmp240 = call %class.Tree  @__GetRight_Tree(i32 %tmp241)
  store %class.Tree %tmp240, %class.Tree * %current_node
  br label %ifEnd17
ifElse17:
  store i1 false, i1 * %cont
  br label %ifEnd17
ifEnd17:
  br label %ifEnd16
ifElse16:
  store i32 1, i32 * %ifound
  store i1 false, i1 * %cont
  br label %ifEnd16
ifEnd16:
  br label %ifEnd14
ifEnd14:
  br label %whileCond4
whileEnd4:
  %tmp242 = load i32 * %ifound
  ret i32 %tmp242
}
define i1 @__Print_Tree(%class.Tree * %this) {
entry20:
  %current_node = alloca %class.Tree
  %ntb = alloca i1
  %tmp243 = load %class.Tree * %this
  store %class.Tree %tmp243, %class.Tree * %current_node
  %tmp245 = load %class.Tree * %current_node
  %tmp244 = call i1  @__RecPrint_Tree(%class.Tree * %this, i1 %tmp245)
  store i1 %tmp244, i1 * %ntb
  ret i1 true
}
define i1 @__RecPrint_Tree(%class.Tree * %this, %class.Tree %node) {
entry21:
  %node_tmp = alloca %class.Tree
  store %class.Tree %node, %class.Tree * %node_tmp
  %ntb = alloca i1
  %tmp247 = load %class.Tree * %node_tmp
  %tmp246 = call i1  @__GetHas_Left_Tree(i1 %tmp247)
  br i1 %tmp246, label %ifThen18, label %ifElse18
ifThen18:
  %tmp250 = load %class.Tree * %node_tmp
  %tmp249 = call %class.Tree  @__GetLeft_Tree(i1 %tmp250)
  %tmp248 = call i1  @__RecPrint_Tree(%class.Tree * %this, %class.Tree %tmp249)
  store i1 %tmp248, i1 * %ntb
  br label %ifEnd18
ifElse18:
  store i1 true, i1 * %ntb
  br label %ifEnd18
ifEnd18:
  %tmp252 = load %class.Tree * %node_tmp
  %tmp251 = call i32  @__GetKey_Tree(i1 %tmp252)
  %tmp253 = getelementptr [4 x i8] * @.formatting.string, i32 0, i32 0
  %tmp254 = call i32 (i8 *, ...)* @printf(i8 * %tmp253, i32 %tmp251)
  %tmp256 = load %class.Tree * %node_tmp
  %tmp255 = call i1  @__GetHas_Right_Tree(i1 %tmp256)
  br i1 %tmp255, label %ifThen19, label %ifElse19
ifThen19:
  %tmp259 = load %class.Tree * %node_tmp
  %tmp258 = call %class.Tree  @__GetRight_Tree(i1 %tmp259)
  %tmp257 = call i1  @__RecPrint_Tree(%class.Tree * %this, %class.Tree %tmp258)
  store i1 %tmp257, i1 * %ntb
  br label %ifEnd19
ifElse19:
  store i1 true, i1 * %ntb
  br label %ifEnd19
ifEnd19:
  ret i1 true
}
define %class.Tree * @__TreeConstructor_Tree(%class.Tree * %this) {
entry22:
  ret %class.Tree * %this
>>>>>>> Stashed changes
}
declare i32 @printf (i8 *, ...)
declare i8 * @malloc (i32)
