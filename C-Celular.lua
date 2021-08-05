------------------------------------------
--- 		CAMARGO SCRIPTS  		   ---
	 -----	 CELULAR BRP		-----
------------------------------------------

local screenW, screenH = guiGetScreenSize()
local resW, resH = 1366, 768
local x, y = (screenW/resW), (screenH/resH)

local CMR_Font_18 = dxCreateFont("font/font.ttf", x*18)
local CMR_Font_16 = dxCreateFont("font/font.ttf", x*16)
local CMR_Font_14 = dxCreateFont("font/font.ttf", x*14)
local CMR_Font_12 = dxCreateFont("font/font.ttf", x*12)
local CMR_Font_11 = dxCreateFont("font/font.ttf", x*11)
local CMR_Font_10 = dxCreateFont("font/font.ttf", x*10)
local CMR_Font_8 = dxCreateFont("font/font.ttf", x*8)
local CMR_Font_6 = dxCreateFont("font/font.ttf", x*6)

local CMR_Font_40 = dxCreateFont("font/font.ttf", x*40)

local CMR_Font_10_impact = dxCreateFont("font/impact.ttf", x*10)

local Biometria = false

local Celular = false

local BoxEdit = createElement("CMR:EditBox:Celular")
local BoxEdit2 = createElement("CMR:EditBox:Celular")

local FundosPadrao
local FundosCell = "img/FundosCell.png"
local IdFundoTelaTroca = 0

local webBrowser = nil
local urlBrowser = ""

local textNumeroLigar = ""

local CalculadoraValorAntes = ""
local CalculadoraValorDps = ""
local CalculadoraMultiplicador = ""

local CelularNumeroLigar = false

local TocSound = false

local TelaInfo = "inicial"

local LigacaoMomento

local IconesCelular = {
	{x*1080, y*205, x*40, y*40, "img/WhatsApp.png", "WhatsApp"},
	{x*1140, y*205, x*40, y*40, "img/Twitter.png", "Twitter"},
	{x*1200, y*205, x*40, y*40, "img/Configuracoes.png", "Configuracoes"},
	{x*1260, y*205, x*40, y*40, "img/Camera.png", "Camera"},

	{x*1080, y*265, x*40, y*40, "img/MercadoLivre.png", "MercadoLivre"},
	{x*1140, y*265, x*40, y*40, "img/Calculadora.png", "Calculadora"},
	{x*1200, y*265, x*40, y*40, "img/Anotacoes.png", "Anotacoes"},
	{x*1260, y*265, x*40, y*40, "img/Ligar.png", "Ligar"},

	{x*1080, y*325, x*40, y*40, "img/Safari.png", "Safari"},
	{x*1140, y*325, x*40, y*40, "img/YouTube.png", "YouTube"},
	{x*1200, y*325, x*40, y*40, "img/Discord.png", "Discord"},
	{x*1260, y*325, x*40, y*40, "img/Anonimo.png", "Anonimo"},

	{x*1080, y*385, x*40, y*40, "img/Facebook.png", "Facebook"},
	{x*1140, y*385, x*40, y*40, "img/TikTok.png", "TikTok"},
	{x*1200, y*385, x*40, y*40, "img/PornHub.png", "PornHub"},
	{x*1260, y*385, x*40, y*40, "img/Google.png", "Google"},

	{x*1080, y*445, x*40, y*40, "img/Gps.png", "Gps"},
	{x*1140, y*445, x*40, y*40, "img/PicPay.png", "PicPay"},
	{x*1200, y*445, x*40, y*40, "img/itau.png", "itau"},

	------------------Icones rapidos celular---------------------
	{x*1080, y*650, x*40, y*40, "img/Ligar.png", "Ligar"},
	{x*1140, y*650, x*40, y*40, "img/WhatsApp.png", "WhatsApp"},
	{x*1200, y*650, x*40, y*40, "img/Twitter.png", "Twitter"},
	{x*1260, y*650, x*40, y*40, "img/Configuracoes.png", "Configuracoes"},
}

function CMR_CelularDX_Celular()
	dxDrawImage(x*1050, y*150, x*290, y*600, FundosCell)
	if Biometria then
		if TelaInfo == "inicial" then
			dxDrawText("By Camargo Scripts", x*1145, y*690, x*150, y*50, tocolor(255, 255, 255, 255), 1.0, CMR_Font_8)
			for i, icons in ipairs(IconesCelular) do
				dxDrawImage(icons[1], icons[2], icons[3], icons[4], icons[5])
			end
		else
			if TelaInfo == "TrocarFundo" then
				dxDrawImage(x*1050, y*150, x*290, y*600, "img/SetaCelular.png")
				dxDrawText("Selecionar", x*1153, y*628, x*80, y*40, tocolor(0, 0, 0, 255), 1.0, CMR_Font_12)
			end
			if TelaInfo == "anonimo" then
				dxDrawEditBox("Digite aqui o texto......", x*1075, y*270, x*245, y*30, false, 100, BoxEdit)
			end
			if TelaInfo == "MercadoLivre" then
				dxDrawEditBox("Digite aqui o texto......", x*1075, y*260, x*245, y*30, false, 100, BoxEdit)
			end
			if TelaInfo == "Twitter" then
				dxDrawEditBox("Digite aqui o texto......", x*1075, y*270, x*245, y*30, false, 100, BoxEdit)
			end
			if TelaInfo == "ligar" then
				dxDrawText(textNumeroLigar, x*1050*2, y*320*2, x*290, y*30, tocolor(0, 0, 0, 255), 1.0, CMR_Font_14, "center", "center")
				if CelularNumeroLigar then
					dxDrawText("Seu número é "..CelularNumeroLigar, x*1050*2, y*380*2, x*290, y*30, tocolor(0, 0, 0, 255), 1.0, CMR_Font_8, "center", "center")
				else
					dxDrawText("Você não possui um chip", x*1050*2, y*380*2, x*290, y*30, tocolor(0, 0, 0, 255), 1.0, CMR_Font_8, "center", "center")
				end
			end
			if TelaInfo == "Gps" then
				dxDrawEditBox("Digite o RG", x*1105, y*320, x*180, y*40, false, 10, BoxEdit)
			end
			if TelaInfo == "itau" then
				dxDrawText((getElementData(localPlayer, "mbank") or "0"), x*1050*2, y*352*2, x*290, y*30, tocolor(0, 0, 0, 255), 1.0, CMR_Font_14, "center", "center")
				dxDrawEditBox("RG do Cidadão", x*1120, y*535, x*150, y*30, false, 100, BoxEdit)
				dxDrawEditBox("Valor", x*1120, y*590, x*150, y*30, false, 100, BoxEdit2)

			end
			if TelaInfo == "PicPay" then
				dxDrawText((getPlayerMoney(localPlayer) or "0"), x*1050*2, y*326*2, x*290, y*30, tocolor(0, 0, 0, 255), 1.0, CMR_Font_14, "center", "center")
				dxDrawEditBox("RG do Cidadão", x*1163, y*462, x*150, y*30, false, 100, BoxEdit)
				dxDrawEditBox("Valor", x*1160, y*517, x*150, y*30, false, 100, BoxEdit2)
			end
			if TelaInfo == "Calculadora" then
				dxDrawText(CalculadoraValorAntes.." "..CalculadoraMultiplicador.." "..CalculadoraValorDps, x*1050*2, y*320*2, x*290, y*30, tocolor(255, 255, 255, 255), 1.0, CMR_Font_14, "center", "center")
			end

			if TelaInfo == "LigandoCall" then
				dxDrawText(getElementData(LigacaoMomento, "CMR:Nome") or "", x*1050*2, y*320*2, x*290, y*30, tocolor(0, 0, 0, 255), 1.0, CMR_Font_14, "center", "center")
			elseif TelaInfo == "Ligacao" then
				dxDrawText(getElementData(LigacaoMomento, "CMR:Nome") or "", x*1050*2, y*320*2, x*290, y*30, tocolor(0, 0, 0, 255), 1.0, CMR_Font_14, "center", "center")	
			else
				dxDrawImage(x*1095, y*695, x*200, y*15, "img/Voltar.png")
			end
		end
	else
		local time = getRealTime()
		local hours = time.hour
		local minutes = time.minute
		local seconds = time.second

		if (hours < 10) then
			hours = "0"..hours
		end
		if (minutes < 10) then
			minutes = "0"..minutes
		end
		dxDrawText(hours..":"..minutes, x*1125, y*230, x*150, y*50, tocolor(255, 255, 255, 255), 1.0, CMR_Font_40)
		dxDrawText("Brasília RP", x*1165, y*290, x*150, y*50, tocolor(255, 255, 255, 255), 1.0, CMR_Font_10)
		dxDrawImage(x*1120, y*350, x*150, y*150, "img/brp.png")
		dxDrawImage(x*1170, y*640, x*50, y*50, "img/Biometria.png")
	end
	dxDrawImage(x*1050, y*150, x*290, y*600, "img/ModeloCelular.png")
end

function CMR_CelularClick_Celular(_, state)
	if state == "down" then
		if not Biometria then
			if isCursor(x*1170, y*640, x*50, y*50) then
				setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
				Biometria = true
				return
			end
		else
			if TelaInfo == "inicial" then
				for a, click in ipairs(IconesCelular) do
					if isCursor(click[1], click[2], click[3], click[4]) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:ExecutarFuncao:Celular", localPlayer, localPlayer, click[6])
						return
					end
				end
			else
				if TelaInfo ~= "Ligacao" or TelaInfo ~= "LigandoCall" then
					if isCursor(x*1095, y*695, x*200, y*15) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						FundosCell = FundosPadrao
						TelaInfo = "inicial"
						return
					end
				end
				if TelaInfo == "configuracoes" then
					if isCursor(x*1070, y*245, x*250, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:ExecutarFuncao:Celular", localPlayer, localPlayer, "TrocarFundo")
					end
				end

				if TelaInfo == "anonimo" then
					if isCursor(x*1235, y*660, x*80, y*35) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:MensagemAnonimo:Celular", localPlayer, localPlayer, getElementData(BoxEdit, "TextEdit"))
						setElementData(BoxEdit, "TextEdit", "")
						return
					end
				end

				if TelaInfo == "MercadoLivre" then
					if isCursor(x*1235, y*625, x*80, y*35) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:MensagemMercadoLivre:Celular", localPlayer, localPlayer, getElementData(BoxEdit, "TextEdit"))
						setElementData(BoxEdit, "TextEdit", "")
						return
					end
				end

				if TelaInfo == "Twitter" then
					if isCursor(x*1235, y*660, x*80, y*35) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:MensagemTwitter:Celular", localPlayer, localPlayer, getElementData(BoxEdit, "TextEdit"))
						setElementData(BoxEdit, "TextEdit", "")
						return
					end
				end

				if TelaInfo == "Gps" then
					if isCursor(x*1105, y*380, x*180, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:EnviarLoc:Celular", localPlayer, localPlayer, getElementData(BoxEdit, "TextEdit"))
						setElementData(BoxEdit, "TextEdit", "")
						return
					end
				end

				if TelaInfo == "itau" then
					if isCursor(x*1147, y*440, x*100, y*80) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:EnviarMoneyItau:Celular", localPlayer, localPlayer, getElementData(BoxEdit, "TextEdit"), getElementData(BoxEdit2, "TextEdit"))
						setElementData(BoxEdit, "TextEdit", "")
						setElementData(BoxEdit2, "TextEdit", "")
						return
					end
				end

				if TelaInfo == "PicPay" then
					if isCursor(x*1165, y*605, x*60, y*60) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:EnviarMoneyPicPay:Celular", localPlayer, localPlayer, getElementData(BoxEdit, "TextEdit"), getElementData(BoxEdit2, "TextEdit"))
						setElementData(BoxEdit, "TextEdit", "")
						setElementData(BoxEdit2, "TextEdit", "")
						return
					end
				end

				if TelaInfo == "ligar" then
					if isCursor(x*1114, y*408, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."1"
					end

					if isCursor(x*1177, y*408, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."2"
					end

					if isCursor(x*1240, y*408, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."3"
					end

					if isCursor(x*1114, y*460, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."4"
					end

					if isCursor(x*1177, y*460, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."5"
					end

					if isCursor(x*1240, y*460, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."6"
					end

					if isCursor(x*1114, y*514, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."7"
					end

					if isCursor(x*1177, y*514, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."8"
					end

					if isCursor(x*1240, y*514, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."9"
					end

					if isCursor(x*1114, y*566, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."*"
					end

					if isCursor(x*1177, y*566, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."0"
					end

					if isCursor(x*1240, y*566, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						textNumeroLigar = textNumeroLigar.."#"
					end

					if isCursor(x*1177, y*618, x*40, y*40) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:LigarFunc:Celular", localPlayer, textNumeroLigar)
					end
				end

				if TelaInfo == "Calculadora" then
					if isCursor(x*1080, y*373, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						CalculadoraValorAntes = ""
						CalculadoraValorDps = ""
						CalculadoraMultiplicador = ""
					end

					if isCursor(x*1080, y*610, x*115, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."0"
						else
							CalculadoraValorDps = CalculadoraValorDps.."0"
						end
					end

					if isCursor(x*1080, y*550, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."1"
						else
							CalculadoraValorDps = CalculadoraValorDps.."1"
						end
					end

					if isCursor(x*1140, y*550, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."2"
						else
							CalculadoraValorDps = CalculadoraValorDps.."2"
						end
					end

					if isCursor(x*1200, y*550, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."3"
						else
							CalculadoraValorDps = CalculadoraValorDps.."3"
						end
					end

					if isCursor(x*1080, y*490, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."4"
						else
							CalculadoraValorDps = CalculadoraValorDps.."4"
						end
					end

					if isCursor(x*1140, y*490, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."5"
						else
							CalculadoraValorDps = CalculadoraValorDps.."5"
						end
					end

					if isCursor(x*1200, y*490, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."6"
						else
							CalculadoraValorDps = CalculadoraValorDps.."6"
						end
					end


					if isCursor(x*1080, y*430, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."7"
						else
							CalculadoraValorDps = CalculadoraValorDps.."7"
						end
					end

					if isCursor(x*1140, y*430, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."8"
						else
							CalculadoraValorDps = CalculadoraValorDps.."8"
						end
					end

					if isCursor(x*1200, y*430, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraMultiplicador == "" then
							CalculadoraValorAntes = CalculadoraValorAntes.."9"
						else
							CalculadoraValorDps = CalculadoraValorDps.."9"
						end
					end




					if isCursor(x*1260, y*430, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraValorAntes == "" then
							return
						end
						CalculadoraMultiplicador = "X"
					end

					if isCursor(x*1260, y*490, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraValorAntes == "" then
							return
						end
						CalculadoraMultiplicador = "-"
					end

					if isCursor(x*1260, y*550, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraValorAntes == "" then
							return
						end
						CalculadoraMultiplicador = "+"
					end

					if isCursor(x*1260, y*373, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						if CalculadoraValorAntes == "" then
							return
						end
						CalculadoraMultiplicador = "/"
					end
					if isCursor(x*1260, y*610, x*50, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:CalculadoraFunc:Celular", localPlayer, CalculadoraValorAntes, CalculadoraMultiplicador, CalculadoraValorDps)
					end

				end

				if TelaInfo == "Ligacao" then
					if isCursor(x*1113, y*545, x*60, y*60) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:CelulaAtendeuLigacao:Celular", localPlayer, LigacaoMomento)
					end

					if isCursor(x*1213, y*545, x*60, y*60) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:CelularFuncDesligar:Celular", localPlayer, LigacaoMomento)
						LigacaoMomento = nil
						FundosCell = FundosPadrao
						TelaInfo = "inicial"
						stopSound(TocSound)
						return
					end
				end

				if TelaInfo == "LigandoCall" then
					if isCursor(x*1165, y*557, x*60, y*60) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:CelularFuncDesligar2:Celular", localPlayer, LigacaoMomento)
						LigacaoMomento = nil
						FundosCell = FundosPadrao
						TelaInfo = "inicial"
						stopSound(TocSound)
						setElementData(localPlayer, "CMR:Voice:Celular", nil)
						setElementData(LigacaoMomento, "CMR:Voice:Celular", nil)
						return
					end
				end

				if TelaInfo == "TrocarFundo" then
					if isCursor(x*1080, y*617, x*30, y*45) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						for i, a in ipairs(Fundos) do
							if (IdFundoTelaTroca-1) <= 0 then
								IdFundoTelaTroca = #Fundos+1
							end
							if (IdFundoTelaTroca-1) == i then
								FundosCell = a[1]
								IdFundoTelaTroca = i
								break
							end
						end
					end
					if isCursor(x*1275, y*617, x*30, y*45) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						for i, a in ipairs(Fundos) do
							if (IdFundoTelaTroca+1) > #Fundos then
								IdFundoTelaTroca = 0
							end
							if (IdFundoTelaTroca+1) == i then
								FundosCell = a[1]
								IdFundoTelaTroca = i
								break
							end
						end
					end

					if isCursor(x*1120, y*617, x*150, y*50) then
						setSoundVolume(playSound("Sound/toque.mp3", false), 0.3)
						triggerServerEvent("CMR:SalvarFundo:Celular", localPlayer, FundosCell)
						FundosPadrao = FundosCell
						TelaInfo = "inicial"
					end

				end

			end
		end
	end
end
function CMR_CelularAbrir_Celular(info)
	if not info then
		FundosCell = "img/FundosCell.png"
		FundosPadrao = "img/FundosCell.png"
	else
		if not info["fundo"] then
			FundosCell = "img/FundosCell.png"
			FundosPadrao = "img/FundosCell.png"
		elseif info["fundo"] == "" then
			FundosCell = "img/FundosCell.png"
			FundosPadrao = "img/FundosCell.png"
		else
			FundosCell = info["fundo"]
			FundosPadrao = info["fundo"]
		end
	end
	textNumeroLigar = ""
	if not Celular then
		if isElement(webBrowser) then
			removeEventHandler("onClientBrowserNavigate", guiGetBrowser(webBrowser), CMR_BrowserNavegation_Celular)
			destroyElement(webBrowser)
			webBrowser = nil
			urlBrowser = ""
		end
		TelaInfo = "inicial"
		addEventHandler("onClientClick", root, CMR_CelularClick_Celular)
		addEventHandler("onClientRender", root, CMR_CelularDX_Celular)
		Celular = true
		Biometria = false
	else
		if isElement(webBrowser) then
			removeEventHandler("onClientBrowserNavigate", guiGetBrowser(webBrowser), CMR_BrowserNavegation_Celular)
			destroyElement(webBrowser)
			webBrowser = nil
			urlBrowser = ""
		end
		TelaInfo = "inicial"
		removeEventHandler("onClientClick", root, CMR_CelularClick_Celular)
		removeEventHandler("onClientRender", root, CMR_CelularDX_Celular)
		Celular = false
		Biometria = false
	end
end
addEvent("CMR:CelularAbrir:Celular", true)
addEventHandler("CMR:CelularAbrir:Celular", root, CMR_CelularAbrir_Celular)

function CMR_CelularAbrirVerifica_Celular()
	triggerServerEvent("CMR:VerificarCelular:Celular", localPlayer)
	triggerServerEvent("CMR:CarregarChip:Celular", localPlayer)
end

bindKey("f1", "down", CMR_CelularAbrirVerifica_Celular)

function CMR_ChipMostrar_Celular(num)
	if num then
		CelularNumeroLigar = num
	end
end
addEvent("CMR:ChipMostrar:Celular", true)
addEventHandler("CMR:ChipMostrar:Celular", root, CMR_ChipMostrar_Celular)

function CMR_ImagemCarregar_Celular(fundo, info)
	if fundo then
		textNumeroLigar = ""
		if info then
			TelaInfo = info
		end
		if TelaInfo == "TrocarFundo" then
			for a, b in ipairs(Fundos) do
				if a == 1 then
					FundosCell = b[1]
					IdFundoTelaTroca = a
				end
			end
		else
			FundosCell = "img/"..fundo..".png"
		end
	end
end
addEvent("CMR:ImagemCarregar:Celular", true)
addEventHandler("CMR:ImagemCarregar:Celular", root, CMR_ImagemCarregar_Celular)

function CMR_CriarNavegador_Celular(url)
	if isElement(webBrowser) then
		removeEventHandler("onClientBrowserNavigate", guiGetBrowser(webBrowser), CMR_BrowserNavegation_Celular)
		destroyElement(webBrowser)
		webBrowser = nil
		urlBrowser = ""
	else
		urlBrowser = "https://"..url
		requestBrowserDomains({"google.com.br", "v16m.tiktokcdn.com", "sf16-scmcdn-va.ibytedtos.com", "p16-va-default.akamaized.ne", "youtube.com.br", "youtube.com", "google.com", "discord.com", "facebook.com.br", "facebook.com", "www.facebook.com", "www.facebook.com.br", "pt.pornhub.com", "www.tiktok.com", "tiktok.com", "s0.ipstatp.com", "s16.tiktokcdn.com", "s16.hypstarcdn.com", "*.tiktokcdn.com", "v16.tiktokcdn.com","p16-va.tiktokcdn.com", "p16-sg-default.akamaized.net", "p16-tiktokcdn-com.akamaized.net", "sf-tb-sg.ibytedtos.com", "google-analytics.com", "googletagmanager.com", "stats.g.doubleclick.net", "mon-va.byteoversea.com", "s0.ipstatp.com", "s16.tiktokcdn.com", "s16.hypstarcdn.com", "v16.tiktokcdn.com", "p16-va.tiktokcdn.com", "p16-va-default.akamaized.net", "p16-sg-default.akamaized.net", "p16-tiktokcdn-com.akamaized.net", "sf-tb-sg.ibytedtos.com", "google-analytics.com", "googletagmanager.com", "stats.g.doubleclick.net", "mon-va.byteoversea.com", "www.google.com.br", "www.google.com", "ai.phncdn.com", "ci.phncdn.com", "di.phncdn.com", "ss.phncdn.com", "ei.phncdn.com", "fonts.googleapis.com", "static.trafficjunky.com", "di.phncdn.com", "as.phncdn.com", "ai.phncdn.com", "ci.phncdn.com", "cs.phncdn.com", "ss.phncdn.com", "cdn1-smallimg.phncdn.com", "www.gstatic.com", "apis.google.com", "ajax.googleapis.com", "fonts.googleapis.com", "www.google-analytics.com", "ads.trafficjunky.net", "static.trafficjunky.com", "media.trafficjunky.net", "vz-cdn2.trafficjunky.net", "hw-cdn2.trafficjunky.net", "vz-cdn2.adtng.com", "a.adtng.com", "hw-cdn2.adtng.com", "ads2.contentabc.com", "m1.nsimg.net", "m2.nsimg.net", "ar-ar.facebook.com", "bg-bg.facebook.com", "bs-ba.facebook.com", "ca-es.facebook.com", "da-dk.facebook.com", "el-gr.facebook.com", "es-la.facebook.com", "es-es.facebook.com", "fa-ir.facebook.com", "fi-fi.facebook.com", "fr-fr.facebook.com", "fr-ca.facebook.com", "hi-in.facebook.com", "hr-hr.facebook.com", "id-id.facebook.com", "it-it.facebook.com", "ko-kr.facebook.com", "mk-mk.facebook.com", "ms-my.facebook.com", "pl-pl.facebook.com", "pt-br.facebook.com", "pt-pt.facebook.com", "ro-ro.facebook.com", "sl-si.facebook.com", "sr-rs.facebook.com", "th-th.facebook.com", "vi-vn.facebook.com", "static.xx.fbcdn.net", "cdn.discordapp.com", "ei.phncdn.com", "*.phncdn.com", "schema.org", "srv277a.com"})
		webBrowser = guiCreateBrowser(x*250, y*180, x*800, y*500, false, false, false)
		addEventHandler("onClientBrowserCreated", guiGetBrowser(webBrowser), function()
			loadBrowserURL(source, urlBrowser)
		end)
		addEventHandler("onClientBrowserNavigate", guiGetBrowser(webBrowser), CMR_BrowserNavegation_Celular)
	end
end
addEvent("CMR:CriarNavegador:Celular", true)
addEventHandler("CMR:CriarNavegador:Celular", root, CMR_CriarNavegador_Celular)

function CMR_BrowserNavegation_Celular(targetURL, isBlocked)
	if isBlocked then
		requestBrowserDomains({targetURL}, true)
		return
	end
end

function CMR_ResultCalculadoraFunc_Celular(valor)
	if valor then
		CalculadoraValorAntes = valor
		CalculadoraValorDps = ""
		CalculadoraMultiplicador = ""
	end
end
addEvent("CMR:ResultCalculadoraFunc:Celular", true)
addEventHandler("CMR:ResultCalculadoraFunc:Celular", root, CMR_ResultCalculadoraFunc_Celular)

function onKey(button)
	if button == "mouse_wheel_down" then
		injectBrowserMouseWheel(webBrowser, -40, 0)
	elseif button == "mouse_wheel_up" then
		injectBrowserMouseWheel(webBrowser, 40, 0)
	end
end


function CMR_RecebendoLigacao_Celular(ligando,info)
	if not ligando then
		return
	end
	if LigacaoMomento then
		triggerServerEvent("CMR:Notification:Celular", localPlayer, ligando, "Já tem uma pessoa na linha!", "error")
		return
	end
	if not info then
		FundosCell = "img/FundosCell.png"
		FundosPadrao = "img/FundosCell.png"
	else
		if not info["fundo"] then
			FundosCell = "img/FundosCell.png"
			FundosPadrao = "img/FundosCell.png"
		elseif info["fundo"] == "" then
			FundosCell = "img/FundosCell.png"
			FundosPadrao = "img/FundosCell.png"
		else
			FundosCell = info["fundo"]
			FundosPadrao = info["fundo"]
		end
	end
	textNumeroLigar = ""
	if not Celular then
		if isElement(webBrowser) then
			removeEventHandler("onClientBrowserNavigate", guiGetBrowser(webBrowser), CMR_BrowserNavegation_Celular)
			destroyElement(webBrowser)
			webBrowser = nil
			urlBrowser = ""
		end
		TelaInfo = "inicial"
		addEventHandler("onClientClick", root, CMR_CelularClick_Celular)
		addEventHandler("onClientRender", root, CMR_CelularDX_Celular)
		Celular = true
		Biometria = true
	end
	setTimer(function()
		LigacaoMomento = ligando
		TelaInfo = "Ligacao"
		Biometria = true
		FundosCell = "img/TelaLigando.png"
		TocSound = playSound("Sound/recebendo.mp3", true)
	end, 100, 1)
end
addEvent("CMR:RecebendoLigacao:Celular", true)
addEventHandler("CMR:RecebendoLigacao:Celular", root, CMR_RecebendoLigacao_Celular)



function CMR_LigandoParaAlguem_Celular(ligando)
	setTimer(function()
		LigacaoMomento = ligando
		TelaInfo = "LigandoCall"
		Biometria = true
		FundosCell = "img/TelaLigacaoAtendida.png"
		TocSound = playSound("Sound/ligando.mp3", true)

	end, 100, 1)
end
addEvent("CMR:LigandoParaAlguem:Celular", true)
addEventHandler("CMR:LigandoParaAlguem:Celular", root, CMR_LigandoParaAlguem_Celular)

function CMR_LigandoParaAlguemDesligar_Celular()
	LigacaoMomento = nil
	FundosCell = FundosPadrao
	TelaInfo = "inicial"
	stopSound(TocSound)
end
addEvent("CMR:LigandoParaAlguemDesligar:Celular", true)
addEventHandler("CMR:LigandoParaAlguemDesligar:Celular", root, CMR_LigandoParaAlguemDesligar_Celular)

function CMR_AtendeuLigacao_Celular(canal)
	if canal then
		TelaInfo = "LigandoCall"
		Biometria = true
		FundosCell = "img/TelaLigacaoAtendida.png"
		stopSound(TocSound)
	end
end
addEvent("CMR:AtendeuLigacao:Celular", true)
addEventHandler("CMR:AtendeuLigacao:Celular", root, CMR_AtendeuLigacao_Celular)


function isCursor(x,y,w,h)
	local mx,my = getCursorPosition()
	if mx and my then
		local fullx,fully = guiGetScreenSize()
		
		cursorx, cursory = mx*fullx,my*fully
		
		if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
			return true
		else
			return false
		end
	end
end
