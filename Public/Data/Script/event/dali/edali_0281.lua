			
--BUS
--大理西门飞往东门

x210281_g_ScriptId = 210281
x210281_g_busGuilList = {1000001, 1000002}


function x210281_OnDefaultEvent( sceneId, selfId, targetId )
	local bSucceeded = 0;
	strText = "Hi畁 t読 kh鬾g th� d鵱g v c咿i, xin 瘙i m祎 l醫";
	for i, busGuid in x210281_g_busGuilList do
		busId = LuaFnBusGetObjIDByGUID(sceneId, busGuid);
		if busId then
			if busId ~= -1 then
				ret = LuaFnBusAddPassenger_Shuttle(sceneId, busId, selfId, targetId, 0);
				if ret == OR_OK then
					strText = "Xin ch�, l t裞 bay"
					bSucceeded = 1;
					break
				elseif ret == OR_BUS_PASSENGERFULL then
					strText = "V c咿i 疸 馥y, xin 疳p chuy猲 sau"
					break
				elseif ret == OR_BUS_HASMOUNT then
					strText = "Khi c咿i v, c醕 h� kh鬾g th� th馽 hi畁 thao t醕 n鄖"
					break
				elseif ret == OR_BUS_HASPET then
					strText = "Khi mang theo tr鈔 th�, c醕 h� kh鬾g th� th馽 hi畁 thao t醕 n鄖"
					break
				elseif ret == OR_BUS_CANNOT_TEAM_FOLLOW then
					strText = "Khi l 鸬i 餴 theo, c醕 h� kh鬾g th� th馽 hi畁 thao t醕 n鄖"
					break
				elseif ret == OR_BUS_CANNOT_DRIDE then
					strText = "Khi c咿i 2 ng叨i, c醕 h� kh鬾g th� th馽 hi畁 thao t醕 n鄖"
					break
				elseif ret == OR_BUS_CANNOT_CHANGE_MODEL then
					strText = "Khi bi猲 th鈔, c醕 h� kh鬾g th� th馽 hi畁 thao t醕 n鄖"
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

--列举事件

--**********************************

function x210281_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId, x210281_g_ScriptId, "Bay t緄 恤ng M鬾", 9, -1);
end

