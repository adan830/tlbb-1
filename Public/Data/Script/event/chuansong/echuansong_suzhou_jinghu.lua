x400003_g_ScriptId = 400003

x400003_left 	=65.0000
x400003_right	=67.0000

x400003_top  	=266.0000
x400003_bottom	=272.0000


--��ҽ���һ�� area ʱ����
function x400003_OnEnterArea( sceneId, selfId )

        BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, x400003_g_ScriptId);
		UICommand_AddString(sceneId, "GotoJinghu");
		UICommand_AddString(sceneId, "K�nh H� l� khu v�c kh�ng t�ng s�t kh�, c�c h� x�c nh�n ti�n v�o?");
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 24)

	--CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 5,277,46)
end

--�����һ�� area ����һ��ʱ��û����ʱ����
function x400003_OnTimer( sceneId, selfId )
	-- ���룬������� area ͣ�������
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5�����δ����
	if StandingTime >= 5000 then
		x400003_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--����뿪һ�� area ʱ����
function x400003_OnLeaveArea( sceneId, selfId )
end

--**********************************
--������ں���
--**********************************
function x400003_GotoJinghu( sceneId, selfId, targetId )	--����������ִ�д˽ű�
	
	-- �������ǲ��ǻ��������Χ��
	if sceneId ~= 1   then
		--C�n � ��ng �i�m truy�n t�ng!
		BeginEvent(sceneId)
			AddText(sceneId,"Ng߽i kh�ng � khu v�c th�ch h�p!")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local targetX, targetZ = GetWorldPos(sceneId, selfId)
	
	if 	targetX < x400003_left or
			targetX > x400003_right or
			targetZ < x400003_top  or
			targetZ > x400003_bottom   then
		
		BeginEvent(sceneId)
			AddText(sceneId,"Ng߽i kh�ng � khu v�c th�ch h�p!")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
			
	end
	
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 5,277,46)
		
end