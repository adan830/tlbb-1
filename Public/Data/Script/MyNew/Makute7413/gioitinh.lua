--转性丹NPC 刘盾

--脚本号
x002191_g_scriptId = 002191


--所拥有的事件ID列表
x002191_g_eventList={0147000, 0147001, 0147002, 0147003, 0147004, 0147005, 0147006}
x002191_g_item_zhuanxingdan = 30900048


x002191_g_result_msg = {
	"#{ZXD_20080312_03}", --"您已成婚无法更改性别，请解除婚姻关系后再使用该物品"
	"#{ZXD_20080318_01}", --"距离太远，转性丹使用失败"
	"#{ZXD_20080318_02}", --"没有可用的转性丹",
	"#{ZXD_20080318_03}", --"组队时无法转性，请退出组队状态后再使用",
	"#{ZXD_20080318_04}", --"摆摊状态时无法使用转性丹",
	"#{ZXD_20080318_05}"  --"乘状态无法使用转性丹"
}

--**********************************
--事件列表
--**********************************
function x002191_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "Nam thanh n� t� 皤u mu痭 c� 疬㧟 t靚h y陁 c黙 m靚h, ta c� th� gi鷓 g� cho ng呓i?" )
		AddNumText( sceneId, x002191_g_scriptId, "Thay 鸨i gi緄 t韓h", 6, 0147000)
		AddNumText( sceneId, x002191_g_scriptId, "H呔ng d鏽 s� d鴑g chuy琻 t韓h 餫n", 11, 0147001)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002191_OnDefaultEvent( sceneId, selfId,targetId )
	x002191_UpdateEventList( sceneId, selfId, targetId )
	AddNumText( sceneId, x002191_g_scriptId,"S豠 dung m誳",6,4)
	AddNumText( sceneId, x002191_g_scriptId,"Ta mu痭 鸨i t阯", 6, 1 )
	AddNumText( sceneId, x002191_g_scriptId,"Thay 鸨i m鄒 t骳",6,2)
	AddNumText( sceneId, x002191_g_scriptId,"Thay 鸨i ki瑄 t骳",6,3)
	AddNumText( sceneId, x002191_g_scriptId,"Nh唼m m鄒 th秈 trang",6,6)
	AddNumText( sceneId, x002191_g_scriptId,"Thay 鸨i bi瑄 t唼ng nh鈔 v",6,5)
end

--**********************************
-- 事件处理
--**********************************
function x002191_OnEventRequest( sceneId, selfId, targetId, eventId )
	local request_id = GetNumText()
	print("function x002191_OnEventRequest")
	if request_id == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 5423 )
	end
	if GetNumText() == 2 then
		CallScriptFunction( 801011, "OnEnumerate",sceneId, selfId, targetId )
	end
	if GetNumText() == 3 then
		CallScriptFunction( 801010, "OnEnumerate",sceneId, selfId, targetId )
	end
	if GetNumText() == 4 then
		CallScriptFunction( 805029, "OnEnumerate",sceneId, selfId, targetId )
	end
	if GetNumText() == 5 then
		CallScriptFunction( 805030, "OnEnumerate",sceneId, selfId, targetId )
	end
	if GetNumText() == 6 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, selfId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  0910281)
	end
	if request_id == 0147000 then
		local isMarried = LuaFnIsMarried(sceneId, selfId)
		if isMarried > 0 then
			BeginEvent(sceneId)
				AddText( sceneId, "#{ZXD_20080312_03}" )		
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		itemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x002191_g_item_zhuanxingdan)
		if itemCount < 1 then
			BeginEvent(sceneId)
				AddText( sceneId, "#{ZXD_20080312_04}" )		
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		--通知客户端开始转性选择
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 0147000)
		
	elseif request_id == 0147003 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 0147005)
		
	elseif request_id == 0147004 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 0147006) --关闭NPC对话框
		
	elseif request_id == 0147001 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZXD_20080312_02}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
-- 请求确认界面
--**********************************
function x002191_OnZhuanXingRequest( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZXD_20080312_05}")
		AddNumText( sceneId, x002191_g_scriptId, "X醕 nh", 6, 0147003)
		AddNumText( sceneId, x002191_g_scriptId, "Hu� b�", 6, 0147004)		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


--**********************************
-- 客户端调用函数
--**********************************
function x002191_OnZhuanXingConfirm( sceneId, selfId, targetId, sex, hairColor, hairModel, faceModel, nFaceId)
	print("x002191_OnZhuanXingConfirm")
	local pre_condition = x002191_PreZhuanXingCondition( sceneId, selfId, targetId )
	if pre_condition == 0 then
		local is_suc = HumanZhuanXing(sceneId, selfId, sex, hairColor, hairModel, faceModel, nFaceId)
		if is_suc == 1 then
			LuaFnDelAvailableItem(sceneId, selfId, x002191_g_item_zhuanxingdan, 1)
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXD_20080312_06}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)

			--变性同时加一个升级特效
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 100 )
			return
		end
	elseif( pre_condition >= 1 and pre_condition <= 6 ) then
		BeginEvent(sceneId)
			AddText(sceneId, x002191_g_result_msg[pre_condition])
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end


--**********************************
-- 是否满足转性条件
--**********************************
function x002191_PreZhuanXingCondition( sceneId, selfId, targetId )
	
	--已经结婚
	local isMarried = LuaFnIsMarried(sceneId, selfId)
	if isMarried == 1 then
		return 1
	end
	
	--距离太远
	local isValidDistance = IsInDist( sceneId, selfId, targetId, 1000.0)
	if isValidDistance <= 0 then
		return 2
	end
	
	--没有合法物品
	local itemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x002191_g_item_zhuanxingdan)
	if itemCount <= 0 then
		return 3
	end
	
	--是否组队
	local hasTeam = LuaFnHasTeam(sceneId, selfId)
	if hasTeam > 0 then
		return 4
	end
	
	--是否摆摊
	local isStall = LuaFnIsStalling(sceneId, selfId)
	if isStall > 0 then
		return 5
	end

	--是否骑乘
	local isRiding = LuaFnIsRiding(sceneId, selfId)
	if isRiding > 0 then
		return 6
	end
	
	--可以转性
	return 0
end
