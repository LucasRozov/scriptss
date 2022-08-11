script_name('ROZOVHELPER') -- название скрипта
script_author('HAYDEN') -- автор скрипта
script_description('ADMIN TUCSON') -- описание скрипта
thisScript("ADMIN HELPER")
script_version("1.2")

require "lib.moonloader" -- подключение библиотеки
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

local update_url = "https://raw.githubusercontent.com/LucasRozov/scriptss/main/update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

local script_url = "https://github.com/LucasRozov/scriptss/blob/main/Admin%20Helper.lua?raw=true" -- тут свою ссылку
local script_path = thisScript().path

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)

_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
nick = sampGetPlayerNickname(playerid)


function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Скрипт успешно загружен.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Регламент был обновлен 11.08.2022.', -1)
 sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Версия: '..script_vers_text ),-1)


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
			sampAddChatMessage("{7FFF00}[RozovHelper]{ffffff} Есть обновление! Версия: " .. updateIni.info.vers_text, -1)
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
			sampAddChatMessage("Скрипт успешно обновлен!", -1)
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
		if imgui.CollapsingHeader(u8'Команды скрипта') then
			imgui.Text(u8'/cheat [ID] - Выдать BAN за Читы\n/zz [ID] - Выдать WARN игроку за DeathMatch в ЗЗ\n/sbiv [ID] - Выдать JAIL[120] за сбив анимации\n/ght [ID] - Соркащение /gethere\n/ghc [IDcar] - Сокращение /getherecar [IDcar]\n/spl [ID] - Сокращение /spplayer\n/caps [ID] - Выдать MUTE за CapsLock\n/mg [ID] - Выдать MUTE за MetaGaming\n/torg [ID] - Выдать MUTE за Торговлю в /j\n/desc [ID] - Удалить ОПИСАНИЕ персонажа игрока на 2 часа\n/oskrod [ID] - Выдать BAN за Оскорбление родных\n/upom [ID] - Выдать BAN[5days] за Упоминание родных\n/afk [ID] - КИКНУТЬ игрока за AFK w/o ESC\n/deagle [radius] [ammo] - Выдать DEAGLE\n/m4 [radius] [ammo] - Выдать M4\n/dildo - Выдать DILDO\n/mp - Выдать PACK оружий "Мероприятие"\n    \n/lvpd - Телепорт в интерьер LVPD (18)\n/lvpd [ID] - Телепорт в интерьер LVPD (18)\n/az - Телепорт в админ зону\n/az [ID] - Телепорт в админ зону с игроком')
		  end
		  if imgui.CollapsingHeader(u8'Правила') then
				imgui.Text(u8'soon228')
		  end
		  if imgui.CollapsingHeader(u8'Стили') then
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

	if 	text:find('В нашем магазине ты можешь приобрести нужное количество игровых денег и потратить', 1, true) or 
		text:find('их на желаемый тобой {FFFFFF}бизнес, дом, аксессуар{6495ED} или на покупку каких-нибудь безделушек.', 1, true) or 
		text:find('Игроки со статусом {FFFFFF}VIP{6495ED} имеют большие возможности, подробнее /help [Преимущества VIP]', 1, true) or
		text:find('можно приобрести редкие {FFFFFF}автомобили, аксессуары, воздушные шары', 1, true) or
		text:find('предметы, которые выделят тебя из толпы! Наш сайт: {FFFFFF}arizona-rp.com', 1, true) then
		return false
	end

	if
		text:find('Вы были телепортированы в интерьер №18 (Las Venturas Police Department)', 1, true) then
		return false
	end

	-- Вы телепортировали игрока %d в админ-зону №2 (Arizona Interior №2)

	if
		text:find(' Вы были телепортированы в админ-зону №2 (Arizona Interior №2)', 1, true) then
		return false
	end
end

sampRegisterChatCommand("cheat", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddCshatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 Читы", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно забанили %s[%d] на 30 дней. Причина:: Чит', nick, id),-1)
	end
end)

sampRegisterChatCommand("zz", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/warn %d DeathMatch в ЗЗ", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно заварнили %s[%d]. Причина: DeathMatch в ЗЗ', nick, id),-1)
	end
end)

sampRegisterChatCommand("sbiv", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/jail %d 120 Сбив анимации", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно посадили %s[%d] c причиной: DeathMatch в ЗЗ', nick, id),-1)
	end
end)

sampRegisterChatCommand("ght", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/gethere %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно телепортировали %s[%d] к себе', nick, id),-1)
	end
end)

sampRegisterChatCommand("ghc", function(arg)
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/getherecar %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно телепортировали машину ID: %d к себе', id),-1)
	end
end)

sampRegisterChatCommand("spl", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/spplayer %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно заспавнили %s[%d]', nick, id),-1)
	end
end)

sampRegisterChatCommand("spc", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/spcar %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно заспавнили машину ID: %d', id), -1)
	end
end)

sampRegisterChatCommand("caps", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/mute %d 30 CapsLock", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно замутили %s[%d]. Причина: СapsLock', nick, id), -1)
	end
end)

sampRegisterChatCommand("mg", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/mute %d 60 MetaGaming", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно замутили %s[%d]. Причина: MetaGaming', nick, id),-1)
	end
end)

sampRegisterChatCommand("desc", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/adeldesc %d 2 NonRP описание персонажа", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно удалили описание %s[%d]. Причина: NonRP описание персонажа', nick, id),-1)
	end
end)

sampRegisterChatCommand("torg", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/mute %d 60 Торговля в /j", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно замутили %s[%d]. Причина: Торговля в /j', nick, id),-1)
	end
end)

sampRegisterChatCommand("oskrod", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 Оскорбление родных", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно забанили %s[%d]. Причина: Оскорбление родных', nick, id),-1)
	end
end)

sampRegisterChatCommand("afk", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/kick %d AFK w/o ESC", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно кикнули %s[%d]. Причина: AFK w/o ESC', nick, id),-1)
	end
end)

sampRegisterChatCommand("no_damage", function(arg)
	nick = sampGetPlayerNickname(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/jail %d 20 ДМ в ЗЗ [Без урона]", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно посадили в деморган %s[%d]. Причина: ДМ в ЗЗ [Без урона]', nick, id),-1)
	end
end)

sampRegisterChatCommand("deagle", function(arg)
    local radius, kolvo = string.match(arg, "(.+) (.+)")
	if radius == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите радиус и количество патронов!', -1)
	else
		sampSendChat(string.format("/gunall %d 24 %d", radius, kolvo))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно выдали Desert Eagle [24] в радиусе %d в количестве %d патронов.', radius, kolvo),-1)
	end
end)

sampRegisterChatCommand("upom", function(arg)
	nick = sampGetPlayerNickname(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/ban %d 5 Упоминание родных", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно забанили %s[%d]. Причина: Упоминание родных', nick, id),-1)
	end
end)

sampRegisterChatCommand("db", function(arg)
	nick = sampGetPlayerNickname(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/jail %d 120 DriveBy", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно посадили %s[%d]. Причина: DriveBy', nick, id),-1)
	end
end)

-- Вы были телепортированы в админ-зону №2 (Arizona Interior №2)

sampRegisterChatCommand("az", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampSendChat(string.format("/az"))
		sampAddChatMessage('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы были телепортированы в админ-зону №2 (Arizona Interior №2)!', -1)
	else
		sampSendChat(string.format("/az %d", id))
		sampAddChatMessage(string.format('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы телепортировали %s[%d] в админ-зону №2 (Arizona Interior №2)', nick, id),-1)
	end
end)

sampRegisterChatCommand("bot", function(arg)
    local id = string.match(arg, "(.+)")
	nick = sampGetPlayerNickname(arg)
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 Бот.", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно забанили %s[%d]. Причина: Бот.', nick, id),-1)
	end
end)

sampRegisterChatCommand("dildo", function(arg)
    local radius, kolvo = string.match(arg, "(.+) (.+)")
	if radius == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите радиус и количество патронов!', -1)
	else
		sampSendChat(string.format("/gunall %d 10 %d", radius, kolvo))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно выдали Purple Dildo [10] в радиусе %d в количестве %d патронов.', radius, kolvo),-1)
	end
end)

sampRegisterChatCommand("m4", function(arg)
    local radius, kolvo = string.match(arg, "(.+) (.+)")
	if radius == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите радиус и количество патронов!', -1)
	else
		sampSendChat(string.format("/gunall %d 31 %d", radius, kolvo))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно выдали M4 [31] в радиусе %d в количестве %d патронов.', radius, kolvo),-1)
	end
end)


function cmd_lvpd(param)
    local id = string.match(param, "(%d+)")
	nick = sampGetPlayerNickname(arg)
        if id == nil then
            sampSendChat(string.format("/gotoint 18"))
			sampAddChatMessage('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы были телепортированы в интерьер №18 (Las Venturas Police Department)!', -1)
        else
            lua_thread.create(function()
				sampSendChat('/gotoint 18')
				wait(500)
				sampSendChat(string.format("/gethere %d", id))
				sampAddChatMessage(string.format('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы телепортировали %s[%d] в интерьер №18 (Las Venturas Police Department)', nick, id),-1)
            end)
        end
end

function cmd_cmd1(param)
    local id = string.match(param, "(%d+)")
	name = sampGetPlayerNickname(param)
        if id == nil then
            sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
        else
            lua_thread.create(function()
				sampSendChat(string.format('/spplayer %d', id))
				wait(500)
				sampSendChat(string.format("/gethere %d", id))
				wait(500)
				sampAddChatMessage(string.format('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы успешно разбагали %s[%d]', name, id),-1)
            end)
        end
end

function cmd_mp(param)
    local radius = string.match(param, "(%d+)")
        if radius == nil then
            sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите радиус выдачи оружия!', -1)
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
				sampAddChatMessage(string.format('{7FFF00}[Rozov Ганы]{ffffff} Вы успешно выдали пак оружий "МП"', id),-1)
            end)
        end
end
