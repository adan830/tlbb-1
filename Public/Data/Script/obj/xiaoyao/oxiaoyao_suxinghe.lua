--��ңNPC
--������
--���Ǻ�
--��ͨ

x014000_g_scriptId = 014000
x014000_g_eventList={225900,229009,200041,200043,200045,200094,808004,229012,808092}
--**********************************
--�¼��������
--**********************************
function x014000_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"Ta l� T� Tinh H�. Ph�i Ti�u Dao th�t s� �� c� ch߷ng m�n nh�n m�i r�i. S� ph� �� giao cho H� Tr�c ch߷ng m�n nh�n chi�c nh�n ng�c Ch߷ng M�n. N�u c�c h� g�p Ch߷ng M�n, xin nh�n gi�m cho t�i h� r�ng b�n ph�i �ang c� ��i s�, c�n ch߷ng m�n nh�n v� gi�i quy�t g�p.")
		local mp = GetMenPai(sceneId, selfId)
		if mp == 9 then 
			AddNumText(sceneId, x014000_g_scriptId, "Gia nh�p m�n ph�i",6,0)
		end
		AddNumText(sceneId, x014000_g_scriptId, "Gi�i thi�u m�n ph�i",8,1)
		AddNumText(sceneId, x014000_g_scriptId, "H�c K� n�ng c�a m�n ph�i?",8,6)		--ָ·������ѧϰ��
		for i, eventId in x014000_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x014000_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x014000_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, MP_XIAOYAO )
			return
		end
	end

	if GetNumText()==0	then

		x014000_g_MenPai = GetMenPai(sceneId, selfId)
		if x014000_g_MenPai == 8   then
			BeginEvent(sceneId)
				AddText(sceneId, "Ng߽i l�i �n ti�u khi�n vi s� r�i, ng߽i �� l� � t� c�a Ti�u Dao ta, c�n b�i s� l�m g� n�a c� ch�")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		if x014000_g_MenPai ~= 9 then
			BeginEvent(sceneId)
				AddText(sceneId,"Ng߽i �� l� cao � c�a m�n ph�i kh�c, ch�ng ta kh�ng thu nh�n ng߽i")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		BeginEvent(sceneId)
			AddText(sceneId, "#{MenpaiInfo_008}")
			AddNumText(sceneId, x014000_g_scriptId, "Ta mu�n gia nh�p ph�i Ti�u Dao",6,3)
			AddNumText(sceneId, x014000_g_scriptId, "T�i h� ch�a mu�n b�i s�",8,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		 
		return
	end
	
	if GetNumText()==4	then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end

	if GetNumText()==3	then
		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 2 then
			BeginEvent(sceneId)
				AddText(sceneId,"H�y s�p x�p l�i tay n�i, c�n 2 v� tr� tr�ng, ta s� th߷ng cho ng߽i!")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif GetLevel( sceneId, selfId ) < 10 then
			BeginEvent(sceneId)
				AddText(sceneId,"C�c h� h�y ��i t�i sau c�p 10 l�i t�i b�i s� h�c ngh�!")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			x014000_g_MenPai = GetMenPai(sceneId, selfId)
			if x014000_g_MenPai == 8 then
				BeginEvent(sceneId)
					AddText(sceneId, "Ng߽i l�i �n ti�u khi�n vi s� r�i, ng߽i �� l� � t� c�a Ti�u Dao ta, c�n b�i s� l�m g� n�a c� ch�")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			--����ֵΪ9��ʾ������
			elseif x014000_g_MenPai==9	then
				LuaFnJoinMenpai(sceneId, selfId, targetId, 8)

				-- ���ó�ʼ��Npc��ϵֵ
				CallScriptFunction( 200099, "InitRelation", sceneId, selfId )

				-- ����ص��ķ�����Ϊ10����  49,52,53
				LuaFnSetXinFaLevel(sceneId,selfId,49,10)
				LuaFnSetXinFaLevel(sceneId,selfId,52,10)
				LuaFnSetXinFaLevel(sceneId,selfId,53,10)

				BeginEvent(sceneId)
					AddText(sceneId,"C�c h� �� gia nh�p ph�i Ti�u Dao!");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				--����ҷ���,��������������,����׬Ǯ
				LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{LevelMail_menpai_8}" )
				--LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{OBJ_xiaoyao_0001}" )
				
				--���ɽ����ټ���
				for i=1, 20 do
					TryRecieveItem( sceneId, selfId, 30501001, 1 )
				end
				x014000_MsgBox( sceneId, selfId, "Nh�n ���c 20 c�i M�n Ph�i Tri�u T�p L�nh" )

				if TryRecieveItem( sceneId, selfId, 10124007, 1 ) >= 0 then
					str		= "#YC�c h� nh�n ���c "..GetItemName( sceneId, 10124007 ).."."
					x014000_MsgBox( sceneId, selfId, str )
				end

				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnMsg2Player( sceneId, selfId,"C�c h� �� gia nh�p ph�i Ti�u Dao!",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 168, 0)
					CallScriptFunction( 225900, "OnDefaultEvent",sceneId, selfId, targetId )
				else
					LuaFnMsg2Player( sceneId, selfId,"C�c h� �� gia nh�p ph�i Ti�u Dao!",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 168, 0)
					CallScriptFunction( 225900, "OnDefaultEvent",sceneId, selfId, targetId )
				end
			else
				BeginEvent(sceneId)
					AddText(sceneId,"Ng߽i �� l� cao � c�a m�n ph�i kh�c, ch�ng ta kh�ng thu nh�n ng߽i")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			end
		end
	elseif	GetNumText()==1	then
		BeginEvent(sceneId)
			AddText(sceneId, "#{OBJ_xiaoyao_0004}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	--ָ·
	if GetNumText()==6 then
		BeginEvent(sceneId)
			AddText(sceneId, "Khang Qu�ng L�ng [125,41] c� th� truy�n d�y cho ng߽i k� n�ng chi�n �u c�a ph�i ta. Y �ang � b�n c�nh ta")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, 125, 41, "Khang Qu�ng L�ng" )
		return
	end
end

--**********************************
--���ܴ�NPC������
--**********************************
function x014000_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x014000_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--�ܾ���NPC������
--**********************************
function x014000_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��Ҫ����NPC���¼��б�
	for i, findId in x014000_g_eventList do
		if missionScriptId == findId then
			x014000_OnDefaultEvent( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�������Ѿ���������
--**********************************
function x014000_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x014000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ�����������
--**********************************
function x014000_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x014000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x014000_OnDie( sceneId, selfId, killerId )
end

--**********************************
--��Ϣ��ʾ
--**********************************
function x014000_MsgBox( sceneId, selfId, str )
	Msg2Player( sceneId, selfId, str, MSG2PLAYER_PARA )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end