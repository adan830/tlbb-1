--飘渺峰 不平道人AI

--F	【暗雷】对自己用一个空技能....再给玩家加个结束后会回调脚本的buff....回调时让BOSS给其周围人加伤寒buff并喊话....
--G 【精算】给自己用一个加buff的技能....
--H 【烟花】对自己用一个空技能....再给玩家加个结束后会回调脚本的buff....回调时喊话....
--I	【朋友】卓不凡死时给自己用一个加buff的技能....


--全程都带有免疫制定技能的buff....
--每隔30秒对随机玩家随机使用FH....
--每隔45秒对自己使用G....
--死亡或脱离战斗时给所有玩家清除FH的buff....
--死亡时寻找不平道人....设置其需要使用狂暴技能....
--死亡时发现不平道人已经死了....则创建另一个BOSS....


--脚本号
x894067_g_ScriptId	= 894067

--副本逻辑脚本号....
x894067_g_FuBenScriptId = 894063

--免疫Buff....
x894067_Buff_MianYi1	= 10472	--免疫一些负面效果....
x894067_Buff_MianYi2	= 10471	--免疫普通隐身....

--技能....
x894067_SkillID_F		= 1805
x894067_BuffID_F1		= 19416

x894067_SkillID_G		= 1806
x894067_SkillID_G_SpecObj		= 188

x894067_SkillID_H		= 1807
x894067_BuffID_H		= 19629

x894067_SkillID_I		= 1804

x894067_SkillCD_FH	=	10000
x894067_SkillCD_G		=	12000
x894067_SkillCD_H	=	12000
x894067_SkillCD_I	=	5000


x894067_MyName			= "Ti陁 Nh� 趛"	--自己的名字....
x894067_BrotherName = "Ti陁 Nh� Qu鈔"	--兄弟的名字....

--AI Index....
x894067_IDX_KuangBaoMode	= 1	--狂暴模式....0未狂暴 1需要进入狂暴 2已经进入狂暴
x894067_IDX_CD_SkillFH		= 2	--FH技能的CD....
x894067_IDX_CD_SkillG			= 3	--G技能的CD....
x894067_IDX_CD_Talk				= 4	--FH技能喊话的CD....
x894067_IDX_CD_SkillI			= 5	--G技能的CD....

x894067_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....

x894067_LootItem_1 = {
39910001, 39910002, 39910003, 39910004, 
}

x894067_LootItem_2 = {
20310184,
}
--**********************************
--初始化....
--**********************************
function x894067_OnInit(sceneId, selfId)
	--重置AI....
	x894067_ResetMyAI( sceneId, selfId )
end


--**********************************
--心跳....
--**********************************
function x894067_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x894067_IDX_CombatFlag ) then
		return
	end

	--FH技能心跳....
	if 1 == x894067_TickSkillFH( sceneId, selfId, nTick ) then
		return
	end

	--G技能心跳....
	if 1 == x894067_TickSkillG( sceneId, selfId, nTick ) then
		return
	end

	--H技能心跳....
	if 1 == x894067_TickSkillH( sceneId, selfId, nTick ) then
		return
	end

	--I技能心跳....
	if 1 == x894067_TickSkillI( sceneId, selfId, nTick ) then
		return
	end

	local nCount = GetMonsterCount(sceneId)
	for i=0, nCount-1  do
		local nObjId = GetMonsterObjID(sceneId, i)
		local MosDataID = GetMonsterDataID( sceneId, nObjId )
		if MosDataID == 15140 then
			LuaFnSendSpecificImpactToUnit( sceneId, nObjId, nObjId, selfId, 19421, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 19422, 0 )
		elseif MosDataID == 15160 then
			LuaFnSendSpecificImpactToUnit( sceneId, nObjId, nObjId, selfId, 19429, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 19430, 0 )
		elseif MosDataID == 15150 then
			LuaFnSendSpecificImpactToUnit( sceneId, nObjId, nObjId, selfId, 19425, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 19426, 0 )
		elseif MosDataID == 15165 then
			LuaFnSendSpecificImpactToUnit( sceneId, nObjId, nObjId, selfId, 19431, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 19432, 0 )
		elseif MosDataID == 15155 then
			LuaFnSendSpecificImpactToUnit( sceneId, nObjId, nObjId, selfId, 19427, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 19428, 0 )
		elseif MosDataID == 15145 then
			LuaFnSendSpecificImpactToUnit( sceneId, nObjId, nObjId, selfId, 19423, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 19424, 0 )
		end
	end

end


--**********************************
--进入战斗....
--**********************************
function x894067_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x894067_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x894067_Buff_MianYi2, 0 )

	--重置AI....
	x894067_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x894067_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x894067_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x894067_ResetMyAI( sceneId, selfId )

	--遍历场景里所有的怪....寻找兄弟并将其删除....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if x894067_BrotherName == GetName( sceneId, MonsterId ) then
			LuaFnDeleteMonster( sceneId, MonsterId )
		end
	end

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )
	CallScriptFunction( x894067_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "PlayHp", 0 )

	--创建对话NPC....
	local MstIdA = CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "XiaoRuJun_NPC", -1, -1 )
	local MstIdB = CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "XiaoRuWei_NPC", -1, -1 )

	SetUnitReputationID( sceneId, MstIdA, MstIdA, 0 )
	SetUnitReputationID( sceneId, MstIdB, MstIdB, 0 )

	local nCount = GetMonsterCount(sceneId)
	for i=0, nCount-1  do
		local nObjId = GetMonsterObjID(sceneId, i)
		local MosDataID = GetMonsterDataID( sceneId, nObjId )
		if MosDataID == 15040 or MosDataID == 15045 or MosDataID == 15050 or MosDataID == 15055 or MosDataID == 15060 or MosDataID == 15065 or MosDataID == 15140 or MosDataID == 15145 or MosDataID == 15150 or MosDataID == 15155 or MosDataID == 15160 or MosDataID == 15165 then
			LuaFnDeleteMonster( sceneId, nObjId )
		end
	end

end


--**********************************
--杀死敌人....
--**********************************
function x894067_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x894067_OnDie( sceneId, selfId, killerId )

	--重置AI....
	x894067_ResetMyAI( sceneId, selfId )

	--如果还没有挑战过乌老大则可以挑战乌老大....
	if 1 ~= CallScriptFunction( x894067_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "YeLvYan" )	then
		CallScriptFunction( x894067_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "YeLvYan", 1 )
	end
	
	-- zchw 全球公告
	local	playerName	= GetName( sceneId, killerId )
	
	--杀死怪物的是宠物则获取其主人的名字....
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
		playerName = GetName( sceneId, playerID )
	end
	
	--如果玩家组队了则获取队长的名字....
	local leaderID = GetTeamLeader( sceneId, playerID )
	if leaderID ~= -1 then
		playerName = GetName( sceneId, leaderID )
	       LuaFnSendSpecificImpactToUnit( sceneId, leaderID, leaderID, leaderID, 19413, 0 )
	end
	
	if playerName ~= nil then
		str = format("姓i ph� tr鷆 l鈓, #{_INFOUSR%s}#P 餫ng 鸶nh r秈 餴 th� ch⺶ ph醫 hi畁 trong 鸠ng 邪ng T鈓 Tr鷆 tan t醕 c黙 #cFF0000Ti陁 Nh� 趛#W xu hi畁 m祎 b鱟 l緉 ch補 馥y b醬 v, li玭 vui m譶g 餰m theo lu鬾!", playerName); --桑土公
		AddGlobalCountNews( sceneId, str )
	end

	CallScriptFunction( x894067_g_FuBenScriptId, "TipAllHuman", sceneId, "Tr D鹡g 姓o Nh鈔: Tuy 疸 疳nh ch猼 Ti陁 Nh� 趛 nh遪g vi甤 ti猵 theo l� ph鋓 l t裞 ti陁 di畉 ngay Ti陁 Nh� Qu鈔. N猽 kh鬾g sau 30 gi鈟 Ti陁 Nh� 趛 s� s痭g l読, l鷆 痼 h qu� kh� m� di璶 t� n眎..." )

   if 2 ~= CallScriptFunction( x894067_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "ShuangZi" )	then
	--取得当前场景里的人数
	local num = LuaFnGetCopyScene_HumanCount( sceneId )
	local mems = {}
	
	for i = 0, num - 1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId( sceneId, i )
	end

	for i = 0, num - 1 do
		if LuaFnIsObjValid( sceneId, mems[i] ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, mems[i] ) == 1 and LuaFnIsCharacterLiving( sceneId, mems[i] ) == 1 then					-- 不在场景的不做此操作

			local WuPin = random( getn(x894067_LootItem_1) )
			AddMonsterDropItem( sceneId, selfId, mems[i], x894067_LootItem_1[WuPin] )
			AddMonsterDropItem( sceneId, selfId, mems[i], 39910001 )

			rand = random(100)
			if rand < 70 then
				AddMonsterDropItem( sceneId, selfId, mems[i], 39910001 )--元宝1W
			end

			rand = random(100)
			if rand < 50 then
				AddMonsterDropItem( sceneId, selfId, mems[i], 20310184 )--玫瑰之恋
			end

			rand = random(100)
			if rand < 10 then
				AddMonsterDropItem( sceneId, selfId, mems[i], 20310184 )--镇南
			end

			rand = random(100)
			if rand < 100 then
				AddMonsterDropItem( sceneId, selfId, mems[i], 20310184 )--镇南
			end

			rand = random(100)
			if rand < 70 then
				local WuPin = random( getn(x894067_LootItem_2) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x894067_LootItem_2[WuPin]  )

			end

			rand = random(100)
			if rand < 50 then
				AddMonsterDropItem( sceneId, selfId, mems[i], 20310184 )--魔盒
			end

		end
	end
   end

	--设置已经挑战过桑土公....
	CallScriptFunction( x894067_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "ShuangZi", 2 )
end


--**********************************
--重置AI....
--**********************************
function x894067_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_KuangBaoMode, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillFH, x894067_SkillCD_FH )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillG, x894067_SkillCD_G )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillH, x894067_SkillCD_H )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillI, x894067_SkillCD_I )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_Talk, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x894067_IDX_CombatFlag, 0 )

	--给所有玩家清除FH的buff....
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			LuaFnCancelSpecificImpact( sceneId, nHumanId, x894067_BuffID_F1 )
			LuaFnCancelSpecificImpact( sceneId, nHumanId, x894067_BuffID_H )
		end
	end

end


--**********************************
--FH技能心跳....
--**********************************
function x894067_TickSkillFH( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.8555 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillFH )
	if cd > nTick then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillFH, cd-nTick )
		return 0

	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillFH, x894067_SkillCD_FH-(nTick-cd) )
		return x894067_UseSkillF( sceneId, selfId )
	end

end


--**********************************
--G技能心跳....
--**********************************
function x894067_TickSkillG( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.8333 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillG )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillG, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillG, x894067_SkillCD_G-(nTick-cd) )
		return x894067_UseSkillG( sceneId, selfId )
	end

end

--**********************************
--H技能心跳....
--**********************************
function x894067_TickSkillH( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.3333 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillH )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillH, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillH, x894067_SkillCD_H-(nTick-cd) )
		return x894067_UseSkillH( sceneId, selfId )
	end

end

--**********************************
--I技能心跳....
--**********************************
function x894067_TickSkillI( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillI )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillI, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894067_IDX_CD_SkillI, x894067_SkillCD_I-(nTick-cd) )
		return x894067_UseSkillI( sceneId, selfId )
	end

end


--**********************************
--使用F技能....
--**********************************
function x894067_UseSkillF( sceneId, selfId )

	--副本中有效的玩家的列表....
	local PlayerList = {}

	--将有效的人加入列表....
	local numPlayer = 0
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			PlayerList[numPlayer+1] = nHumanId
			numPlayer = numPlayer + 1
		end
	end

	--随机挑选一个玩家....
	if numPlayer <= 0 then
		return 0
	end
	local PlayerId = PlayerList[ random(numPlayer) ]

	--对其使用技能....
	local x,z = GetWorldPos( sceneId, PlayerId )
	LuaFnUnitUseSkill( sceneId, selfId, x894067_SkillID_F, PlayerId, x, z, 0, 1 )

	CallScriptFunction((200060), "Paopao",sceneId, "Ti陁 Nh� 趛", "Binh Th醤h K� Tr", "M� th vu l鈓, "..GetName( sceneId, PlayerId ).." ng呓i l鄊 sao c� th� tho醫 th鈔 疬㧟?" )
	CallScriptFunction( x894067_g_FuBenScriptId, "TipAllHuman", sceneId, "Tr D鹡g 姓o Nh鈔: Ti陁 Nh� 趛 疸 s� d鴑g s鷆 kh� v鈟 kh痭, s鷆 kh� m� ho. Ng叨i n鄌 d韓h s鷆 kh� n鄖 l t裞 tr醤h xa t� 鸬i tr醤h b礳 ph醫 s鷆 kh� g鈟 h読 cho chi猲 h鎢 xung quanh!" )

	--给玩家加结束后回调脚本的buff....
	LuaFnSendSpecificImpactToUnit( sceneId, PlayerId, PlayerId, PlayerId, x894067_BuffID_F1, 0 )

	return 1

end


--**********************************
--使用G技能....
--**********************************
function x894067_UseSkillG( sceneId, selfId )


	--副本中有效的玩家的列表....
	local PlayerList = {}

	--将有效的人加入列表....
	local numPlayer = 0
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			PlayerList[numPlayer+1] = nHumanId
			numPlayer = numPlayer + 1
		end
	end

	--随机挑选一个玩家....
	if numPlayer <= 0 then
		return 0
	end

	local PlayerIdA = PlayerList[ random(numPlayer) ]
	local PlayerIdB = PlayerList[ random(numPlayer) ]

	--使用空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x894067_SkillID_G, selfId, x, z, 0, 1 )

	CallScriptFunction((200060), "Paopao",sceneId, "Ti陁 Nh� 趛", "Binh Th醤h K� Tr", "N鷌 r譶g s鬾g n呔c phong c鋘h h鎢 t靚h. #c2ebeff"..GetName( sceneId, PlayerIdA )..", "..GetName( sceneId, PlayerIdB ).."#W, c醕 ng呓i th� li阯 t叻ng m� xem..." )
	CallScriptFunction( x894067_g_FuBenScriptId, "TipAllHuman", sceneId, "Tr D鹡g 姓o Nh鈔: Ti陁 Nh� Qu鈔 疸 ph髇g ra c誱 b鐈 v� h靚h d呔i ch鈔 c醕 v�, 鹱ng 瓞 � 皙n v� b� ngo鄆 c黙 ch鷑g, h銀 n� ch鷑g c鄋g nhanh c鄋g t痶." )

	local x,z = GetWorldPos( sceneId, PlayerIdA )
	CreateSpecialObjByDataIndex(sceneId, selfId, x894067_SkillID_G_SpecObj, x, z, 0)

	local x,z = GetWorldPos( sceneId, PlayerIdB )
	CreateSpecialObjByDataIndex(sceneId, selfId, x894067_SkillID_G_SpecObj, x, z, 0)

	return 1

end


--**********************************
--使用H技能....
--**********************************
function x894067_UseSkillH( sceneId, selfId )

		local Last = CallScriptFunction( x894067_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PlayHp" )
		if Last > 1 then
			return 0
		end

		CallScriptFunction( x894067_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "PlayHp", 2 )

	       --使用空技能....
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, x894067_SkillID_H, selfId, x, z, 0, 1 )

		CallScriptFunction((200060), "Paopao",sceneId, "Ti陁 Nh� 趛", "Binh Th醤h K� Tr", "邪ng T鈓 L鴆 Tr鷆, h銀 痼n h呔ng gi� th眎, n鈔g 疝 th鈔 h靚h ta, ta c ngh� ng絠 l読 s裞 瓞 c騨 gi猼 鸶ch!" )
		CallScriptFunction( x894067_g_FuBenScriptId, "TipAllHuman", sceneId, "Tr D鹡g 姓o Nh鈔: Ti陁 Nh� 趛 疸 tri畊 t 邪ng T鈓 L鴆 Tr鷆 b鋙 h� 瓞 d咿ng s裞. Huynh mu礽 ch鷑g t誱 th秈 疬㧟 mi璶 d竎h. C醕 h� v� t� 鸬i h銀 mau mau ph� h鼀 邪ng T鈓 L鴆 Tr鷆 quy猼 tr� kh� ch鷑g m祎 phen, tr醤h r r痠 sau n鄖!" )

		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "ZhuBai_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "ZhuHong_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "ZhuHuang_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "ZhuLan_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "ZhuLv_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "ZhuZi_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "Bai_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "Hong_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "Huang_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "Lan_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "Lv_BOSS", -1, -1 )
		CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "Zi_BOSS", -1, -1 )

	return 1

end


--**********************************
--使用I技能....
--**********************************
function x894067_UseSkillI( sceneId, selfId )

	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x894067_SkillID_I, selfId, x, z, 0, 1 )

	return 1

end


--**********************************
--暗雷和烟花的buff结束的时候回调本接口....
--**********************************
function x894067_OnImpactFadeOut( sceneId, selfId, impactId )

	--寻找BOSS....
	local bossId = -1
	local MonsterId = -1
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if GetName( sceneId, MonsterId ) == "Ti陁 Nh� 趛" then
			bossId = MonsterId
		end
	end

	--没找到则返回....
	if bossId == -1 then
		return
	end

	--如果是烟花的buff则让BOSS喊话....
	if impactId == 19412 then

		local bok = 0
		local MosDataID = 0
		local nCount = GetMonsterCount(sceneId)
		for i=0, nCount-1  do
			local nObjId = GetMonsterObjID(sceneId, i)
			local MosDataID = GetMonsterDataID( sceneId, nObjId )
			if MosDataID == 15135 then
				bok = 1
			end
		end

		if bok == 0 then
			return
		end

		if bok == 1 then
			local MonsterId = CallScriptFunction( x894067_g_FuBenScriptId, "CreateBOSS", sceneId, "XiaoRuJun_BOSS", -1, -1 )
			LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, 19414, 0 )

			CallScriptFunction( x894067_g_FuBenScriptId, "TipAllHuman", sceneId, "Tr D鹡g 姓o Nh鈔: Huynh 甬 鸢ng t鈓 s裞 m課h phi th叨ng. N猽 trong 30 gi鈟 kh鬾g ti陁 di畉 Ti陁 Nh� 趛 th� Ti陁 Nh� Qu鈔 s� h癷 sinh, l鷆 痼 h qu� th kh� l叨ng!" )

			return
		end

		return
	end

	--如果是暗雷的buff....则让BOSS给附近的玩家加一个伤害的buff并喊话....

	if impactId == x894067_BuffID_F1 then

		local x = 0
		local z = 0
		local xx = 0
		local zz = 0
		x,z = GetWorldPos( sceneId,selfId )
		local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanNum-1  do
			local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId, PlayerId) == 1 then
				xx,zz = GetWorldPos(sceneId,PlayerId)
				if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 12*12 then
					LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, PlayerId, 19418, 0 )
				end
			end
		end

		return

	end


end
