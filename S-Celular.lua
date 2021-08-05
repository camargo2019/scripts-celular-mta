------------------------------------------
--- 		CAMARGO SCRIPTS  		   ---
	 -----	 CELULAR BRP		-----
------------------------------------------

function CMR_CelularDB_Celular(res)
	if res == getThisResource() then
		db = dbConnect("sqlite", "celular.db")
		if db then
			outputDebugString("Sucesso ao se conectar com o banco de dados do celular! [Camargo Scripts]")
		else
			outputDebugString("Erro ao tentar se conectar com banco de dados do celular! [Camargo Scripts]")
		end
	end
end
addEventHandler("onResourceStart", root, CMR_CelularDB_Celular)

function CMR_VerificarCelular_Celular()
	local acc = getPlayerAccount(source)
	if isGuestAccount(acc) then
		return
	end

	local contaLogin = getAccountName(acc)
	if contaLogin then
		local data = dbPoll(dbQuery(db, "SELECT * FROM cmr_celular WHERE contaLogin = ?", contaLogin), -1)
		if data then
			for i, info  in ipairs(data) do
				triggerClientEvent(source, "CMR:CelularAbrir:Celular", source, info)
				return
			end
		end
		exports.cmr_dxmessages:outputDx(source, "Você não tem um celular", "error")
	else
		return
	end
end
addEvent("CMR:VerificarCelular:Celular", true)
addEventHandler("CMR:VerificarCelular:Celular", root, CMR_VerificarCelular_Celular)

function CMR_SalvarFundo_Celular(fundo)
	local acc = getPlayerAccount(source)
	if isGuestAccount(acc) then
		return
	end
	if not fundo then
		return
	end
	local contaLogin = getAccountName(acc)
	if contaLogin then
		local data = dbExec(db, "UPDATE cmr_celular SET fundo = ? WHERE contaLogin = ?", fundo, contaLogin)
		exports.cmr_dxmessages:outputDx(source, "Fundo salvo com sucesso!", "success")
	else
		return
	end
end
addEvent("CMR:SalvarFundo:Celular", true)
addEventHandler("CMR:SalvarFundo:Celular", root, CMR_SalvarFundo_Celular)

function CMR_CarregarChip_Celular()
	if isElement(source) then
		if isGuestAccount(getPlayerAccount(source)) then
			return
		end
		local acc = getAccountName(getPlayerAccount(source))
		if acc then
			local data = dbPoll(dbQuery(db, "SELECT * FROM cmr_chips WHERE contaLogin = ?", acc), -1)
			if data then
				for a, b in ipairs(data) do
					triggerClientEvent(source, "CMR:ChipMostrar:Celular", source, tostring(b["numero"]))
					return
				end
			end 
		end
	end
end
addEvent("CMR:CarregarChip:Celular", true)
addEventHandler("CMR:CarregarChip:Celular", root, CMR_CarregarChip_Celular)

function CMR_ExecutarFuncao_Celular(player, funcao)
	if isElement(player) then
		if isGuestAccount(getPlayerAccount(player)) then
			return
		end

		if not funcao then
			exports.cmr_dxmessages:outputDx(player, "Opss.. você não escolheu a opção!", "error")
			return
		end

		if funcao == "Safari" then
			triggerClientEvent(player, "CMR:CriarNavegador:Celular", player, "google.com.br")
			return
		end
		if funcao == "YouTube" then
			triggerClientEvent(player, "CMR:CriarNavegador:Celular", player, "youtube.com.br")
			return
		end
		if funcao == "Discord" then
			triggerClientEvent(player, "CMR:CriarNavegador:Celular", player, "discord.com")
			return
		end
		if funcao == "Facebook" then
			triggerClientEvent(player, "CMR:CriarNavegador:Celular", player, "facebook.com.br")
			return
		end
		if funcao == "Google" then
			triggerClientEvent(player, "CMR:CriarNavegador:Celular", player, "google.com.br")
			return
		end
		if funcao == "PornHub" then
			triggerClientEvent(player, "CMR:CriarNavegador:Celular", player, "pt.pornhub.com")
			return
		end
		if funcao == "TikTok" then
			triggerClientEvent(player, "CMR:CriarNavegador:Celular", player, "tiktok.com")
			return
		end
		if funcao == "Configuracoes" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "Configuracao", "configuracoes")
			return
		end
		if funcao == "TrocarFundo" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TrocarFundo", "TrocarFundo")
			return
		end
		if funcao == "Anonimo" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaAnonimo", "anonimo")
		end
		if funcao == "Ligar" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaTelefone", "ligar")
		end
		if funcao == "MercadoLivre" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaMercadoLivre", "MercadoLivre")
		end
		if funcao == "Twitter" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaTwitter", "Twitter")
		end
		if funcao == "Gps" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaGps", "Gps")
		end
		if funcao == "Calculadora" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaCalculadora", "Calculadora")
		end
		if funcao == "itau" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaItau", "itau")
		end
		if funcao == "PicPay" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaPicPay", "PicPay")
		end
		if funcao == "WhatsApp" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaManutencao", "WhatsApp")
		end
		if funcao == "Camera" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaManutencao", "Camera")
		end
		if funcao == "Anotacoes" then
			triggerClientEvent(player, "CMR:ImagemCarregar:Celular", player, "TelaManutencao", "Anotacoes")
		end
	end
end
addEvent("CMR:ExecutarFuncao:Celular", true)
addEventHandler("CMR:ExecutarFuncao:Celular", root, CMR_ExecutarFuncao_Celular)


function CMR_MensagemAnonimo_Celular(player, mensagem)
	if mensagem == "" then
		exports.cmr_dxmessages:outputDx(player, "Você precisa escrever uma mensagem!", "error")
		return
	end
	if not mensagem then
		exports.cmr_dxmessages:outputDx(player, "Você precisa escrever uma mensagem!", "error")
		return
	end
	triggerEvent(AnonimoChatEvent, player, player, mensagem)
	return
end
addEvent("CMR:MensagemAnonimo:Celular", true)
addEventHandler("CMR:MensagemAnonimo:Celular", root, CMR_MensagemAnonimo_Celular)

function CMR_MensagemMercadoLivre_Celular(player, mensagem)
	if mensagem == "" then
		exports.cmr_dxmessages:outputDx(player, "Você precisa escrever uma mensagem!", "error")
		return
	end
	if not mensagem then
		exports.cmr_dxmessages:outputDx(player, "Você precisa escrever uma mensagem!", "error")
		return
	end
	triggerEvent(MercadoLivreChatEvent, player, player, mensagem)
	return
end
addEvent("CMR:MensagemMercadoLivre:Celular", true)
addEventHandler("CMR:MensagemMercadoLivre:Celular", root, CMR_MensagemMercadoLivre_Celular)

function CMR_MensagemTwitter_Celular(player, mensagem)
	if mensagem == "" then
		exports.cmr_dxmessages:outputDx(player, "Você precisa escrever uma mensagem!", "error")
		return
	end
	if not mensagem then
		exports.cmr_dxmessages:outputDx(player, "Você precisa escrever uma mensagem!", "error")
		return
	end
	triggerEvent(TwitterChatEvent, player, player, mensagem)
	return
end
addEvent("CMR:MensagemTwitter:Celular", true)
addEventHandler("CMR:MensagemTwitter:Celular", root, CMR_MensagemTwitter_Celular)

function CMR_EnviarLoc_Celular(player, id)
	if not tonumber(id) then
		exports.cmr_dxmessages:outputDx(player, "Coloque um Rg valído!", "error")
		return
	end
	local PlayerID = false
	for i, pl in ipairs(getElementsByType("player")) do
		if tonumber(getElementData(pl, "ID") or false) == tonumber(id) then
			PlayerID = pl
			break
		end
	end
	if not PlayerID then
		exports.cmr_dxmessages:outputDx(player, "Não achamos este cidadão!", "error")
		return
	end
	if PlayerID == player then
		exports.cmr_dxmessages:outputDx(player, "Você não pode enviar localização pra você mesmo!", "error")
		return
	end
	exports.cmr_dxmessages:outputDx(PlayerID, "O Cidadão "..getElementData(player, "CMR:Nome") or "".." enviou uma localização para você!", "info")
	exports.cmr_dxmessages:outputDx(player, "Localização enviada com sucesso!", "success")
	local blip = createBlipAttachedTo(player, 62)
	setElementVisibleTo(blip, root, false)
	setElementVisibleTo(blip, PlayerID, true)
	setTimer(function(blip)
		if isElement(blip) then
			destroyElement(blip)
		end
	end, 90000, 1, blip)
end
addEvent("CMR:EnviarLoc:Celular", true)
addEventHandler("CMR:EnviarLoc:Celular", root, CMR_EnviarLoc_Celular)

function CMR_CalculadoraFunc_Celular(valorantes, multiplicador, valordps)
	if not tonumber(valorantes) then
		exports.cmr_dxmessages:outputDx(source, "Você precisa colocar o valor!", "error")
		return
	end

	if multiplicador == "" then
		exports.cmr_dxmessages:outputDx(source, "Você precisa colocar o valor!", "error")
		return
	end

	if not tonumber(valordps) then
		exports.cmr_dxmessages:outputDx(source, "Você precisa colocar o valor!", "error")
		return
	end

	local ValorResultado

	if multiplicador == "+" then
		ValorResultado = tonumber(valorantes) + tonumber(valordps)
	end
	if multiplicador == "-" then
		ValorResultado = tonumber(valorantes) - tonumber(valordps)
	end
	if multiplicador == "X" then
		ValorResultado = tonumber(valorantes) * tonumber(valordps)
	end
	if multiplicador == "/" then
		ValorResultado = tonumber(valorantes) / tonumber(valordps)
	end
	triggerClientEvent(source, "CMR:ResultCalculadoraFunc:Celular", source, ValorResultado)
end
addEvent("CMR:CalculadoraFunc:Celular", true)
addEventHandler("CMR:CalculadoraFunc:Celular", root, CMR_CalculadoraFunc_Celular)

function CMR_LigarFunc_Celular(telefone)
	if telefone then
		if not tonumber(telefone) then
			exports.cmr_dxmessages:outputDx(source, "Coloque um número correto!", "error")
			return
		end
		local data = dbPoll(dbQuery(db, "SELECT * FROM cmr_chips WHERE numero = ?", tonumber(telefone)), -1)
		local playerNumero
		if data then
			for a, b in ipairs(data) do
				playerNumero = b["contaLogin"]
			end
		end
		if not playerNumero then
			exports.cmr_dxmessages:outputDx(source, "Esse número não existe!", "error")
			return
		end
		local PlayerA
		for a, i in ipairs(getElementsByType("player")) do
			if not isGuestAccount(getPlayerAccount(i)) then
				if getAccountName(getPlayerAccount(i)) == playerNumero then
					PlayerA = i
				end
			end
		end
		if not PlayerA then
			exports.cmr_dxmessages:outputDx(source, "Esse número está fora de área!", "error")
			return
		end
		if PlayerA == source then
			exports.cmr_dxmessages:outputDx(source, "Você não pode ligar para você mesmo!", "error")
			return
		end
		local data = dbPoll(dbQuery(db, "SELECT * FROM cmr_celular WHERE contaLogin = ?", playerNumero), -1)
		if data then
			for i, info  in ipairs(data) do
				triggerClientEvent(PlayerA, "CMR:RecebendoLigacao:Celular", PlayerA, source, info)
				triggerClientEvent(source, "CMR:LigandoParaAlguem:Celular", source, PlayerA)
				return
			end
		end
		exports.cmr_dxmessages:outputDx(source, "Essa pessoal não possui um celular!", "error")
		return
	end
end
addEvent("CMR:LigarFunc:Celular", true)
addEventHandler("CMR:LigarFunc:Celular", root, CMR_LigarFunc_Celular)

function CMR_CelularFuncDesligar_Celular(lig)
	if lig then
		exports.cmr_dxmessages:outputDx(lig, "O "..getElementData(source, "CMR:Nome").." não atendeu a sua ligação!", "info")
		triggerClientEvent(lig, "CMR:LigandoParaAlguemDesligar:Celular", lig)
	end
end
addEvent("CMR:CelularFuncDesligar:Celular", true)
addEventHandler("CMR:CelularFuncDesligar:Celular", root, CMR_CelularFuncDesligar_Celular)

function CMR_CelularFuncDesligar2_Celular(lig)
	if lig then
		triggerClientEvent(lig, "CMR:LigandoParaAlguemDesligar:Celular", lig)
		setElementData(source, "CMR:Voice:Celular", nil)
		setElementData(lig, "CMR:Voice:Celular", nil)
	end
end
addEvent("CMR:CelularFuncDesligar2:Celular", true)
addEventHandler("CMR:CelularFuncDesligar2:Celular", root, CMR_CelularFuncDesligar_Celular)

function CMR_Notification_Celular(pl, mensagem, tipo)
	exports.cmr_dxmessages:outputDx(pl, mensagem, tipo)
end
addEvent("CMR:Notification:Celular", true)
addEventHandler("CMR:Notification:Celular", root, CMR_Notification_Celular)

function CMR_CelulaAtendeuLigacao_Celular(lig)
	if isElement(source) then
		if not isGuestAccount(getPlayerAccount(source)) then
			local numero = math.random(9, 200000)
			triggerClientEvent(source, "CMR:AtendeuLigacao:Celular", source, 0)
			triggerClientEvent(lig, "CMR:AtendeuLigacao:Celular", lig, 0)
			setElementData(source, "CMR:Voice:Celular", numero)
			setElementData(lig, "CMR:Voice:Celular", numero)
			return
		end
	end
end
addEvent("CMR:CelulaAtendeuLigacao:Celular", true)
addEventHandler("CMR:CelulaAtendeuLigacao:Celular", root, CMR_CelulaAtendeuLigacao_Celular)

function CMR_EnviarMoneyItau_Celular(player, id, valor)
	if isElement(player) then
		if isGuestAccount(getPlayerAccount(player)) then
			return
		end

		if not tonumber(id) then
			exports.cmr_dxmessages:outputDx(player, "Coloque um RG valído!", "error")
			return
		end
		if not tonumber(valor) then
			exports.cmr_dxmessages:outputDx(player, "Coloque um valor valído!", "error")
			return
		end
		if tonumber(valor) < 0 then
			exports.cmr_dxmessages:outputDx(player, "Você não pode enviar nada!", "error")
			return
		end
		if tonumber(getElementData(player, "mbank") or 0) < tonumber(valor) then
			exports.cmr_dxmessages:outputDx(player, "Você não tem esse dinheiro!", "error")
			return
		end
		local playerReceber
		for a, b in ipairs(getElementsByType("player")) do
			if not isGuestAccount(getPlayerAccount(b)) then
				if tonumber(getElementData(b, "ID")) == tonumber(id) then
					playerReceber = b
				end
			end
		end
		if not playerReceber then
			exports.cmr_dxmessages:outputDx(player, "Não encontramos essa conta!", "error")
			return
		end
		local valorRecebe = tonumber(getElementData(playerReceber, "mbank") or 0) + tonumber(valor)
		local valorFica = tonumber(getElementData(player, "mbank") or 0) - tonumber(valor) 
		setElementData(playerReceber, "mbank", valorRecebe)
		setElementData(player, "mbank", valorFica)
		exports.cmr_dxmessages:outputDx(player, "Transferencia de R$ "..valor.." feita com sucesso!", "success")
		exports.cmr_dxmessages:outputDx(playerReceber, "Você recebeu uma transferencia de R$ "..valor.." !", "success")		
	end
end
addEvent("CMR:EnviarMoneyItau:Celular", true)
addEventHandler("CMR:EnviarMoneyItau:Celular", root, CMR_EnviarMoneyItau_Celular)


function CMR_EnviarMoneyPicPay_Celular(player, id, valor)
	if isElement(player) then
		if isGuestAccount(getPlayerAccount(player)) then
			return
		end

		if not tonumber(id) then
			exports.cmr_dxmessages:outputDx(player, "Coloque um RG valído!", "error")
			return
		end
		if not tonumber(valor) then
			exports.cmr_dxmessages:outputDx(player, "Coloque um valor valído!", "error")
			return
		end
		if tonumber(valor) < 0 then
			exports.cmr_dxmessages:outputDx(player, "Você não pode enviar nada!", "error")
			return
		end
		if tonumber(getPlayerMoney(player) or 0) < tonumber(valor) then
			exports.cmr_dxmessages:outputDx(player, "Você não tem esse dinheiro!", "error")
			return
		end
		local playerReceber
		for a, b in ipairs(getElementsByType("player")) do
			if not isGuestAccount(getPlayerAccount(b)) then
				if tonumber(getElementData(b, "ID")) == tonumber(id) then
					playerReceber = b
				end
			end
		end
		if not playerReceber then
			exports.cmr_dxmessages:outputDx(player, "Não encontramos essa conta!", "error")
			return
		end
		givePlayerMoney(playerReceber, tonumber(valor))
		takePlayerMoney(player, tonumber(valor))
		exports.cmr_dxmessages:outputDx(player, "Transferencia de R$ "..valor.." feita com sucesso!", "success")
		exports.cmr_dxmessages:outputDx(playerReceber, "Você recebeu uma transferencia de R$ "..valor.." !", "success")		
	end
end

addEvent("CMR:EnviarMoneyPicPay:Celular", true)
addEventHandler("CMR:EnviarMoneyPicPay:Celular", root, CMR_EnviarMoneyPicPay_Celular)
