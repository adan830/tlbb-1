--�����似��ѧϰ

--�ű���
x713531_g_ScriptId = 713531

--��npc��������to� � ��ߵ�c�p
x713531_g_nMaxLevel = 30

--ѧϰ����Ҫ˵to� � ��
x713531_g_MessageStudy = "Ch� c�n c�c h� ch�u b� #{_MONEY%d} m�i c� th� h�c ���c k� n�ng li�n hoa l�c. C�c h� c� quy�t �nh h�c kh�ng?"


--**********************************
--������ں���
--**********************************
function x713531_OnDefaultEvent( sceneId, selfId, targetId, ButtomNum,g_Npc_ScriptId )
	--��Ҽ���to� � ��c�p
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_LIANHUALUO)
	--��Ҽӹ�����to� � ������
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_LIANHUALUO)
	--�����ж�

	--�ж���ng����ngC�i Bang�ɵ���,����ngC�i Bang���Ӳ���ѧϰ
		if GetMenPai(sceneId,selfId) ~= MP_GAIBANG then
			BeginEvent(sceneId)
        		AddText(sceneId,"Ng߽i kh�ng ph�i l� � t� b�n bang, ta kh�ng th� d�y ng߽i");
        	EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	--�ж���ng���Ѿ�ѧ����������,���ѧ����,����ʾ�Ѿ�ѧ����
	if AbilityLevel >= 1 then
		BeginEvent(sceneId)
        	AddText(sceneId,"C�c h� �� h�c xong k� n�ng li�n hoa l�c");
        	EndEvent(sceneId)
        DispatchMissionTips(sceneId,selfId)
		return
	end

	--��� �i�m��to� � ��ng��K� n�ng h�c t�p��(������=0)
	if ButtomNum == 0 then
		
		local tempAbilityId = ABILITY_LIANHUALUO;
		local tempAbilityLevel = 1;
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel);
		if ret and ret == 1 then
			BeginEvent(sceneId)
			--AddText(sceneId,x713531_g_MessageStudy)
			local addText = format(x713531_g_MessageStudy, demandMoney);
			AddText(sceneId,addText)
			--X�c nh�nѧϰ��ť
					AddNumText(sceneId,x713531_g_ScriptId,"T�i h� x�c �nh mu�n h�c", 6, 2)
			--Hu� b�ѧϰ��ť
					AddNumText(sceneId,x713531_g_ScriptId,"T�i h� ch� mu�n coi", 8, 3)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	elseif ButtomNum == 2 then			--��� �i�m��to� � ��ng����X�c nh�nҪѧϰ��
		local tempAbilityId = ABILITY_LIANHUALUO;
		local tempAbilityLevel = 1;
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel);
		if ret and ret == 1 then
			--��������ng����m�t c�i����to� � �ֽ�
			if GetMoney(sceneId,selfId) < demandMoney then			
				BeginEvent(sceneId)
					AddText(sceneId,"C�c h� kh�ng �� ng�n l��ng");
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--�����ҵ�c�p��ng��ﵽҪ��
			if GetLevel(sceneId,selfId) < limitLevel then
				BeginEvent(sceneId)
					AddText(sceneId,"��ng c�p c�a ng߽i kh�ng ��");
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--ɾ����Ǯ
			CostMoney(sceneId,selfId,demandMoney)
			--�����Linh���1
			SetHumanAbilityLevel(sceneId,selfId,ABILITY_LIANHUALUO,1)
			--T�i npc���촰��֪ͨ����Ѿ�ѧ����
			BeginEvent(sceneId)
				AddText(sceneId,"C�c h� �� h�c xong k� n�ng li�n hoa l�c")
			EndEvent( )
			DispatchEventList(sceneId,selfId,targetId)
		end
	else --��� �i�m������ֻ��ng��������
		CallScriptFunction( g_Npc_ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
end

--**********************************
--�о��¼�
--**********************************
function x713531_OnEnumerate( sceneId, selfId, targetId )
		--���������c�p����ʾѡ��
		--if GetLevel(sceneId,selfId) >= 10 then
			AddNumText(sceneId,x713531_g_ScriptId,"H�c k� n�ng li�n hoa l�c", 12, 0)
		--end
		return
end

--**********************************
--���Ti�p th�����
--**********************************
function x713531_CheckAccept( sceneId, selfId )
end

--**********************************
--Ti�p th�
--**********************************
function x713531_OnAccept( sceneId, selfId, ABILITY_LIANHUALUO )
end