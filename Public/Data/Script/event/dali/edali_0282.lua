			
--BUS
--�������ŷ�������

x210282_g_ScriptId = 210282
x210282_g_busGuilList = {1000001, 1000002}


function x210282_OnDefaultEvent( sceneId, selfId, targetId )
	local bSucceeded = 0;
	strText = "Hi�n t�i kh�ng th� d�ng v�t c��i, xin ��i m�t l�t";
	for i, busGuid in x210282_g_busGuilList do
		busId = LuaFnBusGetObjIDByGUID(sceneId, busGuid);
		if busId then
			if busId ~= -1 then
				ret = LuaFnBusAddPassenger_Shuttle(sceneId, busId, selfId, targetId, 0);
				if ret == OR_OK then
					strText = "Xin ch�, l�p t�c bay"
					bSucceeded = 1;
					break
				elseif ret == OR_BUS_PASSENGERFULL then
					strText = "V�t c��i �� �y, xin ��p chuy�n sau"
					break
				elseif ret == OR_BUS_HASMOUNT then
					strText = "Khi c��i v�t, c�c h� kh�ng th� th�c hi�n thao t�c n�y"
					break
				elseif ret == OR_BUS_HASPET then
					strText = "Khi mang theo tr�n th�, c�c h� kh�ng th� th�c hi�n thao t�c n�y"
					break
				elseif ret == OR_BUS_CANNOT_TEAM_FOLLOW then
					strText = "Khi l�p �i �i theo, c�c h� kh�ng th� th�c hi�n thao t�c n�y"
					break
				elseif ret == OR_BUS_CANNOT_DRIDE then
					strText = "Khi c��i 2 ng߶i, c�c h� kh�ng th� th�c hi�n thao t�c n�y"
					break
				elseif ret == OR_BUS_CANNOT_CHANGE_MODEL then
					strText = "Khi bi�n th�n, c�c h� kh�ng th� th�c hi�n thao t�c n�y"
					break
				else
				end
			end
		end
	end

	BeginEvent(sceneId)
		AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)

	if bSucceeded == 1 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId, selfId, 1000)
	end
end



--**********************************

--�о��¼�

--**********************************

function x210282_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId, x210282_g_ScriptId, "Bay t�i T�y M�n", 9, -1);
end
