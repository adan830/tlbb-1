--��������
--��ʦ��Ѱ��L�m Nham
--MisDescBegin
--�ű���
x222900_g_ScriptId = 222900

--�����
x222900_g_MissionId = 1074

--��m�t c�i����to� � ID
--g_MissionIdPre = 

--Ŀ��NPC
x222900_g_Name	="L�m Nham"

--�������
x222900_g_MissionKind = 22

--��ng c�p nhi�m v� 
x222900_g_MissionLevel = 10

--��ng����ngTinhӢ����
x222900_g_IfMissionElite = 0

--������
x222900_g_MissionName="Chi�n �u v� s� m�n"
x222900_g_MissionInfo="#{event_mingjiao_0001}"
x222900_g_MissionTarget="    � Quang Minh ��nh t�m Lam Nham #{_INFOAIM98,105,11, Lam Nham}. "
x222900_g_MissionComplete="  C�c h� l� �ng m�n m�i �n ph�i kh�ng. C�c h� l�m tuy�t l�m. Ta � ��y c� nhi�u vi�c c�n c�c h� gi�p ��"
x222900_g_MoneyBonus=800

--MisDescEnd
--**********************************
--������ں���
--**********************************
function x222900_OnDefaultEvent( sceneId, selfId, targetId )
    --��������ɹ�C�i n�y ����
    if (IsMissionHaveDone(sceneId,selfId,x222900_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x222900_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x222900_g_Name then
			x222900_OnContinue( sceneId, selfId, targetId )
		end
    --Th�a m�n�����������
    elseif x222900_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x222900_g_Name then
			--��������Ti�p th�ʱ��ʾto� � ��Ϣ
			BeginEvent(sceneId)
				AddText(sceneId,x222900_g_MissionName)
				AddText(sceneId,x222900_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x222900_g_MissionTarget)
				
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x222900_g_ScriptId,x222900_g_MissionId)
		end
    end
end

--**********************************
--�о��¼�
--**********************************
function x222900_OnEnumerate( sceneId, selfId, targetId )
	--��������ɹ�C�i n�y ����
	if IsMissionHaveDone(sceneId,selfId,x222900_g_MissionId) > 0 then
		return 
	--����ѽӴ�����
	elseif IsHaveMission(sceneId,selfId,x222900_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x222900_g_Name then
			AddNumText(sceneId, x222900_g_ScriptId,x222900_g_MissionName,2,-1);
		end
	--Th�a m�n�����������
	elseif x222900_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x222900_g_Name then
			AddNumText(sceneId,x222900_g_ScriptId,x222900_g_MissionName,1,-1);
		end
    end
end

--**********************************
--���Ti�p th�����
--**********************************
function x222900_CheckAccept( sceneId, selfId )
	local  MenPai = GetMenPai( sceneId, selfId)
	if	MenPai ~= 1 then
		return 0
	else
		return 1
	end
end

--**********************************
--Ti�p th�
--**********************************
function x222900_OnAccept( sceneId, selfId )
	--������������б�
	AddMission( sceneId,selfId, x222900_g_MissionId, x222900_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#YNh�n nhi�m v�: chi�n �u v� s� m�n",MSG2PLAYER_PARA )
end

--**********************************
--����
--**********************************
function x222900_OnAbandon( sceneId, selfId )
	--ɾ����������б��ж�Ӧto� � ����
    DelMission( sceneId, selfId, x222900_g_MissionId )
end

--**********************************
--����
--**********************************
function x222900_OnContinue( sceneId, selfId, targetId )
	--�ύ����ʱto� � � �i�m���Ϣ
    BeginEvent(sceneId)
		AddText(sceneId,x222900_g_MissionName)
		AddText(sceneId,x222900_g_MissionComplete)
		
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x222900_g_ScriptId,x222900_g_MissionId)
end

--**********************************
--�����ng������ύ
--**********************************
function x222900_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x222900_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--�ύ
--**********************************
function x222900_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x222900_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		AddMoney(sceneId,selfId,x222900_g_MoneyBonus );
		LuaFnAddExp( sceneId, selfId, 800)
		ret = DelMission( sceneId, selfId, x222900_g_MissionId )
		if ret > 0 then
			MissionCom( sceneId, selfId, x222900_g_MissionId )
			Msg2Player(  sceneId, selfId,"#YHo�n t�t nhi�m v�: chi�n �u v� s� m�n",MSG2PLAYER_PARA )
		end
	end
end

--**********************************
--ɱ����������
--**********************************
function x222900_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--���������¼�
--**********************************
function x222900_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--���߸ı�
--**********************************
function x222900_OnItemChanged( sceneId, selfId, itemdataId )
end