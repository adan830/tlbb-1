x402046_g_ScriptId = 402046


x402046_left 	=123.0000
x402046_right	=127.0000

x402046_top  	=170.0000
x402046_bottom  =173.0000


--��ҽ���һ�� area ʱ����
function x402046_OnEnterArea( sceneId, selfId )

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, x402046_g_ScriptId);
		UICommand_AddString(sceneId, "GotoLoulan");
		UICommand_AddString(sceneId, "C�c h� c� ch�c mu�n r�i kh�i Phi�u Di�u Phong?");
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 24)
	
	--CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 186,191,221)
end

--�����һ�� area ����һ��ʱ��û����ʱ����
function x402046_OnTimer( sceneId, selfId )
	-- ���룬������� area ͣ�������
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5�����δ����
	if StandingTime >= 5000 then
		x402046_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--����뿪һ�� area ʱ����
function x402046_OnLeaveArea( sceneId, selfId )
end

--**********************************
--������ں���
--**********************************
function x402046_GotoLoulan( sceneId, selfId, targetId )	--����������ִ�д˽ű�
	
	--�Ƿ��Ǹ���
	local sceneType = LuaFnGetSceneType( sceneId )
	if sceneType ~= 1 then
		return
	end

	
	local targetX, targetZ = GetWorldPos(sceneId, selfId)
	
	if 	targetX < x402046_left or
			targetX > x402046_right or
			targetZ < x402046_top  or
			targetZ > x402046_bottom   then
		
		BeginEvent(sceneId)
			AddText(sceneId,"C�c h� kh�ng n�m trong v�ng d�ch chuy�n.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
			
	end
	
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 186,191,221)
		
end