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

local painel = false

function CMR_LojaDX_Celular()
	dxDrawImage(x*508, y*209, x*350, y*350, "img/LojaDeCelular.png")
end

function CMR_ClickLoja_Celular(_, state)
	if state == "down" then
		if painel then
			if isCursor(x*520, y*455, x*160, y*50) then	
				playSoundFrontEnd(43)
				triggerServerEvent("CMR:ComprarCelular:Celular", localPlayer)
			end

			if isCursor(x*690, y*455, x*160, y*50) then
				playSoundFrontEnd(43)
				triggerServerEvent("CMR:ComprarChip:Celular", localPlayer)
			end

			if isCursor(x*820, y*215, x*30, y*30) then
				CMR_AbrirLoja_Celular()
			end
		end
	end
end

function CMR_AbrirLoja_Celular()
	if not painel then
		painel = true
		showCursor(true)
		addEventHandler("onClientClick", root, CMR_ClickLoja_Celular)
		addEventHandler("onClientRender", root, CMR_LojaDX_Celular)
	else
		painel = false
		showCursor(false)
		removeEventHandler("onClientClick", root, CMR_ClickLoja_Celular)
		removeEventHandler("onClientRender", root, CMR_LojaDX_Celular)
	end
end
addEvent("CMR:AbrirLoja:Celular", true)
addEventHandler("CMR:AbrirLoja:Celular", root, CMR_AbrirLoja_Celular)