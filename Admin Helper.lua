script_name('ROZOVHELPER') -- �������� �������
script_author('HAYDEN') -- ����� �������
script_description('ADMIN TUCSON') -- �������� �������
thisScript("ADMIN HELPER")
script_version("1.2")

require "lib.moonloader" -- ����������� ����������
local keys = require "vkeys"

local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local white_color = "{FFFFFF}"
local prefix = Roza
local se = require 'samp.events'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local vkeys = require 'vkeys'
local themes = import "resource/imgui_themes.lua"
local checked_radio = imgui.ImInt(1)
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'

update_state = false

local script_vers = 3
local script_vers_text = "3.00"

local update_url = "https://raw.githubusercontent.com/LucasRozov/scriptss/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "https://github.com/LucasRozov/scriptss/blob/main/Admin%20Helper.luac?raw=true" -- ��� ���� ������
local script_path = thisScript().path

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)

_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
nick = sampGetPlayerNickname(playerid)


function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������ ������� ��������.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ��������� ��� �������� 11.08.2022.', -1)
 sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} ������: '..script_vers_text ),-1)


sampRegisterChatCommand("zz", cmd_zz)
sampRegisterChatCommand('cheat', cmd_cheat)
sampRegisterChatCommand('zapret', cmd_zapret)
sampRegisterChatCommand('caps', cmd_caps)
sampRegisterChatCommand('db', cmd_db)
sampRegisterChatCommand('mg', cmd_mg)
sampRegisterChatCommand('ppv', cmd_ppv)
sampRegisterChatCommand('dm', cmd_dm)
sampRegisterChatCommand('copov', cmd_copov)
sampRegisterChatCommand('sbiv', cmd_sbiv)
sampRegisterChatCommand('upom', cmd_upom)
sampRegisterChatCommand('oskrod', cmd_oskrod)
sampRegisterChatCommand('ght', cmd_ght)
sampRegisterChatCommand('ghc', cmd_ghc)
sampRegisterChatCommand('spl', cmd_spl)
sampRegisterChatCommand('spc', cmd_spc)
sampRegisterChatCommand('mp', cmd_mp)
sampRegisterChatCommand('lvpd', cmd_lvpd)
sampRegisterChatCommand('cmd1', cmd_cmd1)
sampRegisterChatCommand('helpa', cmd_helpa)
sampRegisterChatCommand('lovlya', cmd_lovlya)
sampRegisterChatCommand('imgui', cmd_imgui)
sampRegisterChatCommand('update', cmd_update)

imgui.Process = false

imgui.SwitchContext()
themes.SwitchColorTheme(1)


downloadUrlToFile(update_url, update_path, function(id, status)
	if status == dlstatus.STATUS_ENDDOWNLOADDATA then
		updateIni = inicfg.load(nil, update_path)
		if tonumber(updateIni.info.vers) > script_vers then
			sampAddChatMessage("{7FFF00}[RozovHelper]{ffffff} ���� ����������! ������: " .. updateIni.info.vers_text, -1)
			update_state = true
		end
		os.remove(update_path)
	end
end)


 while true do
  wait(0)

  if main_window_state.v == false then
	imgui.Process = false
end

if update_state then
	downloadUrlToFile(script_url, script_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			sampAddChatMessage("������ ������� ��������!", -1)
			thisScript():reload()
		end
	end)
	break
end

end
end

function imgui.OnDrawFrame()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(600, 400), imgui.Cond.FirstUseEver)
	imgui.Begin(u8'Admin Helper', main_window_state)
		if imgui.CollapsingHeader(u8'������� �������') then
			imgui.Text(u8'/cheat [ID] - ������ BAN �� ����\n/zz [ID] - ������ WARN ������ �� DeathMatch � ��\n/sbiv [ID] - ������ JAIL[120] �� ���� ��������\n/ght [ID] - ���������� /gethere\n/ghc [IDcar] - ���������� /getherecar [IDcar]\n/spl [ID] - ���������� /spplayer\n/caps [ID] - ������ MUTE �� CapsLock\n/mg [ID] - ������ MUTE �� MetaGaming\n/torg [ID] - ������ MUTE �� �������� � /j\n/desc [ID] - ������� �������� ��������� ������ �� 2 ����\n/oskrod [ID] - ������ BAN �� ����������� ������\n/upom [ID] - ������ BAN[5days] �� ���������� ������\n/afk [ID] - ������� ������ �� AFK w/o ESC\n/deagle [radius] [ammo] - ������ DEAGLE\n/m4 [radius] [ammo] - ������ M4\n/dildo - ������ DILDO\n/mp - ������ PACK ������ "�����������"\n    \n/lvpd - �������� � �������� LVPD (18)\n/lvpd [ID] - �������� � �������� LVPD (18)\n/az - �������� � ����� ����\n/az [ID] - �������� � ����� ���� � �������')
		  end
		  if imgui.CollapsingHeader(u8'�������') then
				imgui.Text(u8'soon228')
		  end
		  if imgui.CollapsingHeader(u8'�����') then
			imgui.BeginChild("ChildWindow2", imgui.ImVec2(200, 175), true)
            for i, value in ipairs(themes.colorThemes) do
                if imgui.RadioButton(value, checked_radio, i) then
                    themes.SwitchColorTheme(i) 
                end
            end
        imgui.EndChild()
		  end
	imgui.End()
end

function cmd_helpa(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end

function se.onServerMessage(color, text)
	if color == 0x73B461FF and text:match('^%[ News .. %]') then
		return false
	end

	if 	text:find('� ����� �������� �� ������ ���������� ������ ���������� ������� ����� � ���������', 1, true) or 
		text:find('�� �� �������� ����� {FFFFFF}������, ���, ���������{6495ED} ��� �� ������� �����-������ ����������.', 1, true) or 
		text:find('������ �� �������� {FFFFFF}VIP{6495ED} ����� ������� �����������, ��������� /help [������������ VIP]', 1, true) or
		text:find('����� ���������� ������ {FFFFFF}����������, ����������, ��������� ����', 1, true) or
		text:find('��������, ������� ������� ���� �� �����! ��� ����: {FFFFFF}arizona-rp.com', 1, true) then
		return false
	end

	if
		text:find('�� ���� ��������������� � �������� �18 (Las Venturas Police Department)', 1, true) then
		return false
	end

	-- �� ��������������� ������ %d � �����-���� �2 (Arizona Interior �2)

	if
		text:find(' �� ���� ��������������� � �����-���� �2 (Arizona Interior �2)', 1, true) then
		return false
	end
end

sampRegisterChatCommand("cheat", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddCshatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 ����", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� %s[%d] �� 30 ����. �������:: ���', nick, id),-1)
	end
end)

sampRegisterChatCommand("zz", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/warn %d DeathMatch � ��", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ��������� %s[%d]. �������: DeathMatch � ��', nick, id),-1)
	end
end)

sampRegisterChatCommand("sbiv", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/jail %d 120 ���� ��������", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� %s[%d] c ��������: DeathMatch � ��', nick, id),-1)
	end
end)

sampRegisterChatCommand("ght", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/gethere %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ��������������� %s[%d] � ����', nick, id),-1)
	end
end)

sampRegisterChatCommand("ghc", function(arg)
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/getherecar %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ��������������� ������ ID: %d � ����', id),-1)
	end
end)

sampRegisterChatCommand("spl", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/spplayer %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ���������� %s[%d]', nick, id),-1)
	end
end)

sampRegisterChatCommand("spc", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/spcar %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ���������� ������ ID: %d', id), -1)
	end
end)

sampRegisterChatCommand("caps", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/mute %d 30 CapsLock", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� %s[%d]. �������: �apsLock', nick, id), -1)
	end
end)

sampRegisterChatCommand("mg", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/mute %d 60 MetaGaming", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� %s[%d]. �������: MetaGaming', nick, id),-1)
	end
end)

sampRegisterChatCommand("desc", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/adeldesc %d 2 NonRP �������� ���������", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ������� �������� %s[%d]. �������: NonRP �������� ���������', nick, id),-1)
	end
end)

sampRegisterChatCommand("torg", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/mute %d 60 �������� � /j", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� %s[%d]. �������: �������� � /j', nick, id),-1)
	end
end)

sampRegisterChatCommand("oskrod", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 ����������� ������", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� %s[%d]. �������: ����������� ������', nick, id),-1)
	end
end)

sampRegisterChatCommand("afk", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/kick %d AFK w/o ESC", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ������� %s[%d]. �������: AFK w/o ESC', nick, id),-1)
	end
end)

sampRegisterChatCommand("no_damage", function(arg)
	nick = sampGetPlayerNickname(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/jail %d 20 �� � �� [��� �����]", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� � �������� %s[%d]. �������: �� � �� [��� �����]', nick, id),-1)
	end
end)

sampRegisterChatCommand("deagle", function(arg)
    local radius, kolvo = string.match(arg, "(.+) (.+)")
	if radius == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ������ � ���������� ��������!', -1)
	else
		sampSendChat(string.format("/gunall %d 24 %d", radius, kolvo))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ������ Desert Eagle [24] � ������� %d � ���������� %d ��������.', radius, kolvo),-1)
	end
end)

sampRegisterChatCommand("upom", function(arg)
	nick = sampGetPlayerNickname(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/ban %d 5 ���������� ������", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� %s[%d]. �������: ���������� ������', nick, id),-1)
	end
end)

sampRegisterChatCommand("db", function(arg)
	nick = sampGetPlayerNickname(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/jail %d 120 DriveBy", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� %s[%d]. �������: DriveBy', nick, id),-1)
	end
end)

-- �� ���� ��������������� � �����-���� �2 (Arizona Interior �2)

sampRegisterChatCommand("az", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampSendChat(string.format("/az"))
		sampAddChatMessage('{7FFF00}[Rozov �������]{ffffff} �� ���� ��������������� � �����-���� �2 (Arizona Interior �2)!', -1)
	else
		sampSendChat(string.format("/az %d", id))
		sampAddChatMessage(string.format('{7FFF00}[Rozov �������]{ffffff} �� ��������������� %s[%d] � �����-���� �2 (Arizona Interior �2)', nick, id),-1)
	end
end)

sampRegisterChatCommand("bot", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 ���.", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� %s[%d]. �������: ���.', nick, id),-1)
	end
end)

sampRegisterChatCommand("dildo", function(arg)
    local radius, kolvo = string.match(arg, "(.+) (.+)")
	if radius == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ������ � ���������� ��������!', -1)
	else
		sampSendChat(string.format("/gunall %d 10 %d", radius, kolvo))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ������ Purple Dildo [10] � ������� %d � ���������� %d ��������.', radius, kolvo),-1)
	end
end)

sampRegisterChatCommand("m4", function(arg)
    local radius, kolvo = string.match(arg, "(.+) (.+)")
	if radius == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ������ � ���������� ��������!', -1)
	else
		sampSendChat(string.format("/gunall %d 31 %d", radius, kolvo))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ������ M4 [31] � ������� %d � ���������� %d ��������.', radius, kolvo),-1)
	end
end)


function cmd_lvpd(param)
    local id = string.match(param, "(%d+)")
	nick = sampGetPlayerNickname(arg)
        if id == nil then
            sampSendChat(string.format("/gotoint 18"))
			sampAddChatMessage('{7FFF00}[Rozov �������]{ffffff} �� ���� ��������������� � �������� �18 (Las Venturas Police Department)!', -1)
        else
            lua_thread.create(function()
				sampSendChat('/gotoint 18')
				wait(500)
				sampSendChat(string.format("/gethere %d", id))
				sampAddChatMessage(string.format('{7FFF00}[Rozov �������]{ffffff} �� ��������������� %s[%d] � �������� �18 (Las Venturas Police Department)', nick, id),-1)
            end)
        end
end

function cmd_cmd1(param)
    local id = string.match(param, "(%d+)")
	name = sampGetPlayerNickname(param)
        if id == nil then
            sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
        else
            lua_thread.create(function()
				sampSendChat(string.format('/spplayer %d', id))
				wait(500)
				sampSendChat(string.format("/gethere %d", id))
				wait(500)
				sampAddChatMessage(string.format('{7FFF00}[Rozov �������]{ffffff} �� ������� ��������� %s[%d]', name, id),-1)
            end)
        end
end

function cmd_mp(param)
    local radius = string.match(param, "(%d+)")
        if radius == nil then
            sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ������ ������ ������!', -1)
        else
            lua_thread.create(function()
				sampSendChat(string.format('/gunall %d 24 500', radius))
				wait(500)
				sampSendChat(string.format("/gunall %d 31 500", radius))
				wait(500)
				sampSendChat(string.format("/gunall %d 26 500", radius))
				wait(500)
				sampSendChat(string.format("/gunall %d 28 500", radius))
				wait(500)
				sampSendChat(string.format("/hpall %d", radius))
				wait(500)
				sampSendChat(string.format("/armourall %d", radius))
				wait(500)
				sampAddChatMessage(string.format('{7FFF00}[Rozov ����]{ffffff} �� ������� ������ ��� ������ "��"', id),-1)
            end)
        end
end
