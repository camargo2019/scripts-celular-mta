------------------------------------------
--- 		CAMARGO SCRIPTS  		   ---
	 -----	 CELULAR BRP		-----
------------------------------------------

local MarkerLojaCriado = {}

function CMR_CriarMarker_Celular(res)
	if res == getThisResource() then 
		for a, mrk in ipairs(MarkerLoja) do
			MarkerLojaCriado[a] = createMarker(mrk[1], mrk[2], mrk[3]-1, "cylinder", 1.5, 0, 0, 255, 170)
			createBlipAttachedTo(MarkerLojaCriado[a], mrk[4])
		end
	end
end
addEventHandler("onResourceStart", root, CMR_CriarMarker_Celular)

function CMR_MarkerHit_Celular(marker)
	if marker then
		for i, bb in ipairs(MarkerLojaCriado) do
			if bb == marker then
				if not isGuestAccount(getPlayerAccount(source)) then
					triggerClientEvent(source, "CMR:AbrirLoja:Celular", source)
				end
			end
		end
	end
end
addEventHandler("onPlayerMarkerHit", root, CMR_MarkerHit_Celular)

function CMR_ComprarCelular_Celular()
	if isElement(source) then
		if isGuestAccount(getPlayerAccount(source)) then
			return
		end
		local valorMoney = getPlayerMoney(source)
		if valorMoney < 10000 then
			exports.cmr_dxmessages:outputDx(source, "Você não tem dinheiro suficiente!", "error")
			return
		end
		local data = dbPoll(dbQuery(db, "SELECT * FROM cmr_celular WHERE contaLogin = ?", getAccountName(getPlayerAccount(source))), -1)
		if data then
			for a, b in ipairs(data) do
				exports.cmr_dxmessages:outputDx(source, "Você já tem um celular!", "error")
				return
			end
		end
		takePlayerMoney(source, 10000)
		dbExec(db, "INSERT INTO cmr_celular VALUES (NULL, ?, NULL)", getAccountName(getPlayerAccount(source)))
		exports.cmr_dxmessages:outputDx(source, "Você adquiriu com sucesso!", "success")
	end
end
addEvent("CMR:ComprarCelular:Celular", true)
addEventHandler("CMR:ComprarCelular:Celular", root, CMR_ComprarCelular_Celular)

function CMR_ComprarChip_Celular()
	if isElement(source) then
		if isGuestAccount(getPlayerAccount(source)) then
			return
		end

		local valorMoney = getPlayerMoney(source)
		if valorMoney < 500 then
			exports.cmr_dxmessages:outputDx(source, "Você não tem dinheiro suficiente!", "error")
			return
		end
		local data = dbPoll(dbQuery(db, "SELECT * FROM cmr_chips WHERE contaLogin = ?", getAccountName(getPlayerAccount(source))), -1)
		if data then
			for a, b in ipairs(data) do
				exports.cmr_dxmessages:outputDx(source, "Você já tem um chip!", "error")
				return
			end
		end
		takePlayerMoney(source, 500)
		dbExec(db, "INSERT INTO cmr_chips VALUES (NULL, ?)", getAccountName(getPlayerAccount(source)))
		exports.cmr_dxmessages:outputDx(source, "Você adquiriu com sucesso!", "success")
	end
end
addEvent("CMR:ComprarChip:Celular", true)
addEventHandler("CMR:ComprarChip:Celular", root, CMR_ComprarChip_Celular)
