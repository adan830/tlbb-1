--����NPC
--��վ....

x002026_g_ScriptId	= 002026

--������Ϣ(�������ƣ�SceneID��PosX��PosY������ID)
x002026_g_mpInfo		= {}
x002026_g_mpInfo[0]	= { "Tinh T�c", 16,  96, 152, MP_XINGSU }
x002026_g_mpInfo[1]	= { "Ti�u Dao", 14,  67, 145, MP_XIAOYAO }
x002026_g_mpInfo[2]	= { "Thi�u L�m",  9,  96, 127, MP_SHAOLIN }
x002026_g_mpInfo[3]	= { "Thi�n S�n", 17,  95, 120, MP_TIANSHAN }
x002026_g_mpInfo[4]	= { "Thi�n Long", 13,  96, 120, MP_DALI }
x002026_g_mpInfo[5]	= { "Nga My", 15,  89, 139, MP_EMEI }
x002026_g_mpInfo[6]	= { "V� �ang", 12, 103, 140, MP_WUDANG }
x002026_g_mpInfo[7]	= { "Minh Gi�o", 11,  98, 167, MP_MINGJIAO }
x002026_g_mpInfo[8]	= { "C�i Bang", 10,  91, 116, MP_GAIBANG }
--x002026_g_mpInfo[9]	= { "M� Dung", 435,  91, 116, MP_GAIBANG }

x002026_g_Yinpiao = 40002000 

x002026_g_Impact_NotTransportList = { 5929, 5944 } -- ��ֹ���͵�Impact
x002026_g_TalkInfo_NotTransportList = { "#{GodFire_Info_062}", "#{XSHCD_20080418_099}" } -- ��ֹ���͵�Impact��ʾ��Ϣ

--**********************************
--�¼��������
--**********************************
function x002026_OnDefaultEvent( sceneId, selfId,targetId )
	
	-- �����������ǲ����С���Ʊ������������оͲ���ʹ������Ĺ���
	if GetItemCount(sceneId, selfId, x002026_g_Yinpiao)>=1  then
		BeginEvent( sceneId )
			AddText( sceneId, "Ng߽i �ang trong tr�ng th�i Th߽ng Nh�n, kh�ng th� d�ch chuy�n!" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	local	mp
	local	i		= 0
	BeginEvent( sceneId )

		AddText( sceneId, "#{loulan_yizhan_20080329}")
		 
		AddNumText( sceneId, x002026_g_ScriptId, "Quay v� m�n ph�i", 9, 1000 )
		AddNumText( sceneId, x002026_g_ScriptId, "Th�nh Th� - L�c D߽ng", 9, 1001 )
		AddNumText( sceneId, x002026_g_ScriptId, "Th�nh Th� - L�c D߽ng - C�u Ch�u Th߽ng H�i", 9, 1002 )
		AddNumText( sceneId, x002026_g_ScriptId, "Th�nh Th� - T� Ch�u", 9, 1003 )
		AddNumText( sceneId, x002026_g_ScriptId, "Th�nh Th� - T� Ch�u - Thi�t T��ng Ph�", 9, 1004 )
		AddNumText( sceneId, x002026_g_ScriptId, "Th�nh Th� - L�u Lan", 9, 1005 )
		AddNumText( sceneId, x002026_g_ScriptId, "Th�nh Th� - Th�c H� C� Tr�n", 9, 1016 )
		AddNumText( sceneId, x002026_g_ScriptId, "Th�nh Th� - #GPh��ng Minh Tr�n", 9, 1017 )
		 
		AddNumText( sceneId, x002026_g_ScriptId, "�i c�u ��i M�n Ph�i", 9, 1011 )
		
		--for i, mp in x002026_g_mpInfo do
			--AddNumText( sceneId, x002026_g_ScriptId, "���� - "..mp[1], 9, i )
		--end

	
	
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

end

--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x002026_OnEventRequest( sceneId, selfId, targetId, eventId )

	--���˽�ֹ����....
	if GetTeamId(sceneId,selfId)>=0 and 
		IsTeamFollow(sceneId, selfId)==1 and
		LuaFnIsTeamLeader(sceneId,selfId)==1 then
		num=LuaFnGetFollowedMembersCount( sceneId, selfId)
		local mems = {}
		for	i=0,num-1 do
			mems[i] = GetFollowedMember(sceneId, selfId, i)
			if mems[i] == -1 then
				return
			end
			if IsHaveMission(sceneId,mems[i],4021) > 0 then
				x002026_MsgBox( sceneId, selfId, targetId, "T� �i c�a ng߽i c� th�nh vi�n �ang trong tr�ng th�i T�o V�n, kh�ng th� d�ch chuy�n!" )
				return
			end
		end
	end

	if IsHaveMission(sceneId,selfId,4021) > 0 then
		x002026_MsgBox( sceneId, selfId, targetId, "Ng߽i �ang trong tr�ng th�i T�o V�n, kh�ng th� d�ch chuy�n!" )
		return
	end

	--���Impact״̬פ��Ч��
	for i, ImpactId in x002026_g_Impact_NotTransportList do
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactId) ~= 0 then
			x002026_MsgBox( sceneId, selfId, targetId, x002026_g_TalkInfo_NotTransportList[i] )			
			return 0
		end
	end

	
	--��������....
	local	arg	= GetNumText()
	local	mp
	local	i		= 0
	local	id	= LuaFnGetMenPai( sceneId, selfId )
	if arg == 1000 then		--��������
		if id < 0 or (id == 9 and LuaFnGetXinFaLevel(sceneId,selfId,64) <= 0) then --Add by S�i
			x002026_MsgBox( sceneId, selfId, targetId, "Ng߽i v�n ch�a gia nh�p m�n ph�i." )
		elseif id == 9 and LuaFnGetXinFaLevel(sceneId,selfId,64) > 0 then --Add by S�i
			CallScriptFunction((400900),"TransferFunc",sceneId,selfId,435,91,116)
		else
			mp	= x002026_GetMPInfo( id )
			if mp ~= nil then
				CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4] )
			end
		end
		return
	end

	--����....
	if arg == 1001 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 0, 233, 321 )
		return
	end

	--��������....
	if arg == 1002 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 0, 325, 270 )
		return
	end

	--����....
	if arg == 1003 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 202,257 )
		return
	end

	--��������....
	if arg == 1004 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 331, 226 )
		return
	end

	--¥��....
	if arg == 1005 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 286, 129 )
		return
	end

	--������....
	if arg == 1017 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 580, 158, 120 )
		return
	end

	if arg == 1011 then		
		BeginEvent( sceneId )
			for i, mp in x002026_g_mpInfo do
				AddNumText( sceneId, x002026_g_ScriptId, "M�n ph�i - "..mp[1], 9, i )
			end
			
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	
		return
	end
	
	if arg == 1016 then		--���ӹ���
			-- add by zchw
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, x002026_g_ScriptId);
			-- zchw fix Transfer bug
			UICommand_AddInt(sceneId, targetId);
			UICommand_AddString(sceneId, "GotoShuHeGuZhen");
			UICommand_AddString(sceneId, "Th�c H� C� Tr�n l� khu v�c kh�ng t�ng s�t kh�, ng߽i x�c �nh �i ti�p?");
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 24)
		return
	end
	
	--����....
	for i, mp in x002026_g_mpInfo do
		if arg == i then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4] )
			return
		end
	end

end
--  add by zchw
function x002026_GotoShuHeGuZhen( sceneId, selfId, targetId )
	CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 420, 200, 211, 20 );
	return
end
--**********************************
--��������ID��ȡ������Ϣ
--**********************************
function x002026_GetMPInfo( mpID )
	local	mp
	local	i		= 0
	for i, mp in x002026_g_mpInfo do
		if mp[5] == mpID then
			return mp
		end
	end
	return nil
end

--**********************************
--�Ի�������Ϣ��ʾ
--**********************************
function x002026_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end