--��ҽ���һ�� area ʱ����
function x400116_OnEnterArea( sceneId, selfId )
	if	GetLevel( sceneId, selfId)<10 then
		BeginEvent(sceneId)
			strText = "C�n ��t c�p 10 tr� l�n m�i c� th� �n n�i n�y!"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	else
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 16,98,143, 10)
	end
end

--�����һ�� area ����һ��ʱ��û����ʱ����
function x400116_OnTimer( sceneId, selfId )
	-- ���룬������� area ͣ�������
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5�����δ����
	if StandingTime >= 5000 then
		x400116_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--����뿪һ�� area ʱ����
function x400116_OnLeaveArea( sceneId, selfId )
end