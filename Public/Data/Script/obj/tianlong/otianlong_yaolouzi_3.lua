--����NPC
--Mu�i mu�i Thi�n Ti�n
--��ͨ

--**********************************
--�¼��������
--**********************************
function x013017_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"Mu�i mu�i Thi�n Ti�n~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end