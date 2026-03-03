-- ▀█▀ █▀▄ ▄▀▄ █▄ █ ▄▀▀ █   ▄▀▄ ▀█▀ ██▀
--  █  █▀▄ █▀█ █ ▀█ ▄██ █▄▄ █▀█  █  █▄▄
Config.Language = 'EN' -- 'EN' / 'DE' / 'FR' / 'ES' / 'PT' / 'CZ' / 'IT' / 'NL' / 'PL'

Config.Translate = {
    ['EN'] = {
        ['notify.you_are_not_owner'] = "You don't own the store, you can't do it.",

        ['notify.order:trailer_unattached'] = "The trailer has been unhitched, hook up the trailer.",
        ['notify.order:trailer_attached'] = "The trailer has been reattached, drive on.",
        ['notify.order:trailer_destroyed'] = "The trailer has been destroyed, return to the store.",
        
        ['notify.order:area_is_occupied'] = "The delivery space in front of the dealership is occupied, you have to wait until it becomes vacant.",
        ['notify.order:not_enought_budget_for_accept'] = "The dealership budget does not allow it to make this order.",
        ['notify.order:order_was_made'] = "You've made your vehicle order, now you can go to pick it up.",
        ['notify.order:reward_for_delivery'] = "You were paid %s$ for delivering.",
        ['notify.order:already_accepted_by_you'] = "This order is already accepted by you.",
        ['notify.order:already_accepted_other'] = "This order is already accepted by another employee.",
        ['notify.order:stock_is_full'] = "You cannot accept the order because there are too many vehicles in the stock.",
        ['notify.order:stock_is_full_delivery'] = "You cannot delivery the order because there are too many vehicles in the stock.",
        ['notify.order:max_selected'] = "You have selected the maximum number of vehicles to order.",

        ['notify.employees:no_players_around'] = "No players around.",
        ['notify.employees:player_is_offline'] = "You can't do it, the player is not available.",
        ['notify.employees:player_is_too_far_away'] = "The player is too far away to be employed",
        ['notify.employees:player_is_already_employed'] = "This player is already an employee at this store.",
        ['notify.employees:player_is_not_employed'] = "This player is not an employee at this store",
        ['notify.employees:must_be_unemployed'] = "This player is already employed somewhere.",
        ['notify.employees:you_employee_hired'] = "A new employee has been hired!",
        ['notify.employees:awarded_bonus'] = "You awarded a $%s bonus to an employee.",
        ['notify.employees:received_bonus'] = "Received a bonus of $%s from the store you work at.",

        ['notify.balance:withdraw'] = "You withdrew $%s from the company's funds",
        ['notify.balance:deposit'] = "You have deposited $%s into the company safe.",
        ['notify.balance:you_dont_have_that_money'] = "You don't have that much money...",
        ['notify.balance:store_dont_have_that_money'] = "Dealership doesn't have that much money...",

        ['notify.sell:cant_resell_to_yourself'] = "You can't sell a vehicle to yourself.",
        ['notify.sell:not_enought_money'] = "You don't have enough money to make a purchase of this vehicle.",
        ['notify.sell:you_sold_vehicle_with_percent'] = "You sold %s %s vehicle for %s$ and received %s$ from the sale.",
        ['notify.sell:you_sold_vehicle'] = "You sold %s %s vehicle for %s$.",
        ['notify.sell:purchased_vehicle'] = "You purchased a %s %s for %s$.",

        ['notify.testdrive:no_money'] = "You don't have enough money to test the vehicle.",
        ['notify.testdrive:area_is_occupied'] = "Space for test drive is currently occupied.",

        ['notify.purchase:success'] = "Congratulations!<br>You have purchased a new vehicle: %s %s for $%s.",
        ['notify.purchase:you_dont_have_license'] = "You don't have required license.",
        ['notify.purchase:you_dont_have_money'] = "You don't have money for this vehicle.",
        ['notify.purchase:dealership_doesnt_have_it_in_stock'] = "Dealership doesn't have it in the stock right now.",
        ['notify.purchase:go_to_dealer'] = "You can't buy a vehicle, go to a dealership employee.",

        ['help.showroom'] = "~INPUT_CONTEXT~ Showroom %s",
        ['help.contract'] = "~INPUT_CONTEXT~ Sign the contract",
        ['help.management'] = "~INPUT_CONTEXT~ Management",

        ['3dtext.showroom'] = "~g~[E]~s~ Showroom<br>%s",
        ['3dtext.contract'] = "~g~[E]~s~ Sign the contract",
        ['3dtext.management'] = "~y~[E]~s~ Management",

        ['target.showroom'] = "Showroom %s",
        ['target.contract'] = "Sign the contract",
        ['target.management'] = "Management",

        ['announcement.cityhall'] = "Cityhall",
    },
    ['DE'] = {
        ['notify.you_are_not_owner'] = "Du besitzt das Geschäft nicht, du kannst es nicht tun.",

        ['notify.order:trailer_unattached'] = "Der Anhänger wurde abgehängt, hänge den Anhänger wieder an.",
        ['notify.order:trailer_attached'] = "Der Anhänger wurde wieder angehängt, fahre weiter.",
        ['notify.order:trailer_destroyed'] = "Der Anhänger wurde zerstört, kehre zum Geschäft zurück.",
        
        ['notify.order:area_is_occupied'] = "Der Lieferplatz vor dem Autohaus ist besetzt, du musst warten, bis er frei wird.",
        ['notify.order:not_enought_budget_for_accept'] = "Das Budget des Autohauses erlaubt es nicht, diese Bestellung aufzugeben.",
        ['notify.order:order_was_made'] = "Du hast deine Fahrzeugbestellung aufgegeben, jetzt kannst du es abholen.",
        ['notify.order:reward_for_delivery'] = "Du hast %s$ für die Lieferung erhalten.",
        ['notify.order:already_accepted_by_you'] = "Diese Bestellung wurde bereits von dir akzeptiert.",
        ['notify.order:already_accepted_other'] = "Diese Bestellung wurde bereits von einem anderen Mitarbeiter akzeptiert.",
        ['notify.order:stock_is_full'] = "Du kannst die Bestellung nicht annehmen, da zu viele Fahrzeuge im Lager sind.",
        ['notify.order:stock_is_full_delivery'] = "Du kannst die Bestellung nicht zustellen, da zu viele Fahrzeuge im Lager sind.",
        ['notify.order:max_selected'] = "Du hast die maximale Anzahl an Fahrzeugen für die Bestellung ausgewählt.",

        ['notify.employees:no_players_around'] = "Keine Spieler in der Nähe.",
        ['notify.employees:player_is_offline'] = "Du kannst es nicht tun, der Spieler ist nicht verfügbar.",
        ['notify.employees:player_is_too_far_away'] = "Der Spieler ist zu weit entfernt, um eingestellt zu werden.",
        ['notify.employees:player_is_already_employed'] = "Dieser Spieler arbeitet bereits als Mitarbeiter in diesem Geschäft.",
        ['notify.employees:player_is_not_employed'] = "Dieser Spieler ist kein Mitarbeiter in diesem Geschäft.",
        ['notify.employees:must_be_unemployed'] = "Dieser Spieler ist bereits an anderer Stelle angestellt.",
        ['notify.employees:you_employee_hired'] = "Ein neuer Mitarbeiter wurde eingestellt!",
        ['notify.employees:awarded_bonus'] = "Du hast einen Bonus von $%s an einen Mitarbeiter vergeben.",
        ['notify.employees:received_bonus'] = "Du hast einen Bonus von $%s vom Geschäft erhalten, in dem du arbeitest.",

        ['notify.balance:withdraw'] = "Du hast $%s aus den Firmenfonds abgehoben.",
        ['notify.balance:deposit'] = "Du hast $%s in den Geschäftstresor eingezahlt.",
        ['notify.balance:you_dont_have_that_money'] = "Du hast nicht so viel Geld...",
        ['notify.balance:store_dont_have_that_money'] = "Das Autohaus hat nicht so viel Geld...",

        ['notify.sell:cant_resell_to_yourself'] = "Du kannst ein Fahrzeug nicht an dich selbst verkaufen.",
        ['notify.sell:not_enought_money'] = "Du hast nicht genug Geld, um den Kauf dieses Fahrzeugs zu tätigen.",
        ['notify.sell:you_sold_vehicle_with_percent'] = "Du hast %s %s Fahrzeug für %s$ verkauft und %s$ aus dem Verkauf erhalten.",
        ['notify.sell:you_sold_vehicle'] = "Du hast %s %s Fahrzeug für %s$ verkauft.",
        ['notify.sell:purchased_vehicle'] = "Du hast ein %s %s für %s$ gekauft.",

        ['notify.testdrive:no_money'] = "Du hast nicht genug Geld, um das Fahrzeug zu testen.",
        ['notify.testdrive:area_is_occupied'] = "Der Platz für die Probefahrt ist derzeit besetzt.",

        ['notify.purchase:success'] = "Herzlichen Glückwunsch!<br>Du hast ein neues Fahrzeug gekauft: %s %s für $%s.",
        ['notify.purchase:you_dont_have_license'] = "Du hast nicht die erforderliche Lizenz.",
        ['notify.purchase:you_dont_have_money'] = "Du hast nicht genug Geld für dieses Fahrzeug.",

        ['help.showroom'] = "~INPUT_CONTEXT~ Ausstellungsraum %s",
        ['help.contract'] = "~INPUT_CONTEXT~ Vertrag unterschreiben",
        ['help.management'] = "~INPUT_CONTEXT~ Management",

        ['3dtext.showroom'] = "~g~[E]~s~ Ausstellungsraum<br>%s",
        ['3dtext.contract'] = "~g~[E]~s~ Vertrag unterschreiben",
        ['3dtext.management'] = "~y~[E]~s~ Management",

        ['target.showroom'] = "Ausstellungsraum %s",
        ['target.contract'] = "Vertrag unterschreiben",
        ['target.management'] = "Management",

        ['announcement.cityhall'] = "Rathaus"
    },
    ['FR'] = {
        ['notify.you_are_not_owner'] = "Vous n'êtes pas le propriétaire du magasin, vous ne pouvez pas le faire.",

        ['notify.order:trailer_unattached'] = "La remorque a été détachée, attachez-la à nouveau.",
        ['notify.order:trailer_attached'] = "La remorque a été rattachée, continuez à conduire.",
        ['notify.order:trailer_destroyed'] = "La remorque a été détruite, retournez au magasin.",

        ['notify.order:area_is_occupied'] = "L'espace de livraison devant la concession est occupé, vous devez attendre qu'il se libère.",
        ['notify.order:not_enought_budget_for_accept'] = "Le budget de la concession ne permet pas de passer cette commande.",
        ['notify.order:order_was_made'] = "Vous avez passé votre commande de véhicule, maintenant vous pouvez aller le récupérer.",
        ['notify.order:reward_for_delivery'] = "Vous avez été payé %s$ pour la livraison.",
        ['notify.order:already_accepted_by_you'] = "Cette commande est déjà acceptée par vous.",
        ['notify.order:already_accepted_other'] = "Cette commande est déjà acceptée par un autre employé.",
        ['notify.order:stock_is_full'] = "Vous ne pouvez pas accepter la commande car il y a trop de véhicules en stock.",
        ['notify.order:stock_is_full_delivery'] = "Vous ne pouvez pas livrer la commande car il y a trop de véhicules en stock.",
        ['notify.order:max_selected'] = "Vous avez sélectionné le nombre maximum de véhicules à commander.",

        ['notify.employees:no_players_around'] = "Aucun joueur autour.",
        ['notify.employees:player_is_offline'] = "Vous ne pouvez pas le faire, le joueur n'est pas disponible.",
        ['notify.employees:player_is_too_far_away'] = "Le joueur est trop loin pour être employé.",
        ['notify.employees:player_is_already_employed'] = "Ce joueur est déjà un employé de ce magasin.",
        ['notify.employees:player_is_not_employed'] = "Ce joueur n'est pas un employé de ce magasin.",
        ['notify.employees:must_be_unemployed'] = "Ce joueur est déjà employé ailleurs.",
        ['notify.employees:you_employee_hired'] = "Un nouvel employé a été embauché !",
        ['notify.employees:awarded_bonus'] = "Vous avez attribué une prime de %s$ à un employé.",
        ['notify.employees:received_bonus'] = "Vous avez reçu une prime de %s$ du magasin où vous travaillez.",

        ['notify.balance:withdraw'] = "Vous avez retiré %s$ des fonds de l'entreprise.",
        ['notify.balance:deposit'] = "Vous avez déposé %s$ dans le coffre de l'entreprise.",
        ['notify.balance:you_dont_have_that_money'] = "Vous n'avez pas autant d'argent...",
        ['notify.balance:store_dont_have_that_money'] = "La concession n'a pas autant d'argent...",

        ['notify.sell:cant_resell_to_yourself'] = "Vous ne pouvez pas revendre un véhicule à vous-même.",
        ['notify.sell:not_enought_money'] = "Vous n'avez pas assez d'argent pour acheter ce véhicule.",
        ['notify.sell:you_sold_vehicle_with_percent'] = "Vous avez vendu %s %s véhicule pour %s$ et avez reçu %s$ de la vente.",
        ['notify.sell:you_sold_vehicle'] = "Vous avez vendu %s %s véhicule pour %s$.",
        ['notify.sell:purchased_vehicle'] = "Vous avez acheté un %s %s pour %s$.",

        ['notify.testdrive:no_money'] = "Vous n'avez pas assez d'argent pour tester le véhicule.",
        ['notify.testdrive:area_is_occupied'] = "L'espace d'essai est actuellement occupé.",

        ['notify.purchase:success'] = "Félicitations!<br>Vous avez acheté un nouveau véhicule : %s %s pour %s$.",
        ['notify.purchase:you_dont_have_license'] = "Vous n'avez pas le permis requis.",
        ['notify.purchase:you_dont_have_money'] = "Vous n'avez pas l'argent pour ce véhicule.",

        ['help.showroom'] = "~INPUT_CONTEXT~ Salle d'exposition %s",
        ['help.contract'] = "~INPUT_CONTEXT~ Signer le contrat",
        ['help.management'] = "~INPUT_CONTEXT~ Gestion",

        ['3dtext.showroom'] = "~g~[E]~s~ Salle d'exposition<br>%s",
        ['3dtext.contract'] = "~g~[E]~s~ Signer le contrat",
        ['3dtext.management'] = "~y~[E]~s~ Gestion",

        ['target.showroom'] = "Salle d'exposition %s",
        ['target.contract'] = "Signer le contrat",
        ['target.management'] = "Gestion",

        ['announcement.cityhall'] = "Hôtel de Ville"
    },
    ['ES'] = {
        ['notify.you_are_not_owner'] = "No eres el dueño de la tienda, no puedes hacerlo.",
    
        ['notify.order:trailer_unattached'] = "El remolque ha sido desenganchado, engancha el remolque.",
        ['notify.order:trailer_attached'] = "El remolque ha sido reenganchado, continua conduciendo.",
        ['notify.order:trailer_destroyed'] = "El remolque ha sido destruido, regresa a la tienda.",
        
        ['notify.order:area_is_occupied'] = "El espacio de entrega frente al concesionario esta ocupado, tienes que esperar hasta que este vacio.",
        ['notify.order:not_enought_budget_for_accept'] = "El presupuesto del concesionario no permite realizar este pedido.",
        ['notify.order:order_was_made'] = "Has realizado tu pedido de vehiculo, ahora puedes ir a recogerlo.",
        ['notify.order:reward_for_delivery'] = "Has sido pagado %s$ por la entrega.",
        ['notify.order:already_accepted_by_you'] = "Este pedido ya ha sido aceptado por ti.",
        ['notify.order:already_accepted_other'] = "Este pedido ya ha sido aceptado por otro empleado.",
        ['notify.order:stock_is_full'] = "No puedes aceptar el pedido porque hay demasiados vehiculos en stock.",
        ['notify.order:stock_is_full_delivery'] = "No puedes entregar el pedido porque hay demasiados vehiculos en stock.",
        ['notify.order:max_selected'] = "Has seleccionado el numero maximo de vehiculos para pedir.",
    
        ['notify.employees:no_players_around'] = "No hay jugadores alrededor.",
        ['notify.employees:player_is_offline'] = "No puedes hacerlo, el jugador no esta disponible.",
        ['notify.employees:player_is_too_far_away'] = "El jugador esta demasiado lejos para ser contratado",
        ['notify.employees:player_is_already_employed'] = "Este jugador ya es empleado en esta tienda.",
        ['notify.employees:player_is_not_employed'] = "Este jugador no es empleado en esta tienda",
        ['notify.employees:must_be_unemployed'] = "Este jugador ya esta empleado en otro lugar.",
        ['notify.employees:you_employee_hired'] = "Se ha contratado a un nuevo empleado!",
        ['notify.employees:awarded_bonus'] = "Has otorgado un bono de $%s a un empleado.",
        ['notify.employees:received_bonus'] = "Recibiste un bono de $%s de la tienda en la que trabajas.",
    
        ['notify.balance:withdraw'] = "Has retirado $%s de los fondos de la empresa",
        ['notify.balance:deposit'] = "Has depositado $%s en la caja fuerte de la empresa.",
        ['notify.balance:you_dont_have_that_money'] = "No tienes tanto dinero...",
        ['notify.balance:store_dont_have_that_money'] = "El concesionario no tiene tanto dinero...",
    
        ['notify.sell:cant_resell_to_yourself'] = "No puedes venderte un vehiculo a ti mismo.",
        ['notify.sell:not_enought_money'] = "No tienes suficiente dinero para comprar este vehiculo.",
        ['notify.sell:you_sold_vehicle_with_percent'] = "Vendiste el vehiculo %s %s por %s$ y recibiste %s$ de la venta.",
        ['notify.sell:you_sold_vehicle'] = "Vendiste el vehiculo %s %s por %s$.",
        ['notify.sell:purchased_vehicle'] = "Compraste un %s %s por %s$.",
    
        ['notify.testdrive:no_money'] = "No tienes suficiente dinero para probar el vehiculo.",
        ['notify.testdrive:area_is_occupied'] = "El espacio para la prueba de conduccion esta actualmente ocupado.",
    
        ['notify.purchase:success'] = "Felicidades!<br>Has comprado un nuevo vehiculo: %s %s por $%s.",
        ['notify.purchase:you_dont_have_license'] = "No tienes la licencia requerida.",
        ['notify.purchase:you_dont_have_money'] = "No tienes dinero para este vehiculo.",
        ['notify.purchase:dealership_doesnt_have_it_in_stock'] = "La concesionaria no lo tiene en stock en este momento.",
        ['notify.purchase:go_to_dealer'] = "No puedes comprar un vehículo, ve a un empleado de la concesionaria.",
    
        ['help.showroom'] = "~INPUT_CONTEXT~ Sala de exposicion %s",
        ['help.contract'] = "~INPUT_CONTEXT~ Firmar el contrato",
        ['help.management'] = "~INPUT_CONTEXT~ Administracion",
    
        ['3dtext.showroom'] = "~g~[E]~s~ Sala de exposicion<br>%s",
        ['3dtext.contract'] = "~g~[E]~s~ Firmar el contrato",
        ['3dtext.management'] = "~y~[E]~s~ Administracion",
    
        ['target.showroom'] = "Sala de exposicion %s",
        ['target.contract'] = "Firmar el contrato",
        ['target.management'] = "Administracion",

        ['announcement.cityhall'] = "Ayuntamiento"
    },
    ['PT'] = {
        ['notify.you_are_not_owner'] = "Não és proprietário da loja, não podes fazer isto.",
        
        ['notify.order:trailer_unattached'] = "O reboque foi desligado, volta a ligá-lo.",
        ['notify.order:trailer_attached'] = "O reboque foi novamente ligado, continua a viagem.",
        ['notify.order:trailer_destroyed'] = "O reboque foi destruído, regressa à loja.",
        
        ['notify.order:area_is_occupied'] = "O espaço de entrega em frente à concessionária está ocupado, tens de esperar até que fique vago.",
        ['notify.order:not_enought_budget_for_accept'] = "A verba do concessionário não permite fazer este pedido.",
        ['notify.order:order_was_made'] = "Fizeste o teu pedido de veículo, agora podes ir buscá-lo.",
        ['notify.order:reward_for_delivery'] = "Recebeste %s$ pela entrega.",
        ['notify.order:already_accepted_by_you'] = "Este pedido já foi aceite por ti.",
        ['notify.order:already_accepted_other'] = "Este pedido já foi aceite por outro funcionário.",
        ['notify.order:stock_is_full'] = "Não podes aceitar o pedido porque há demasiados veículos no stock.",
        ['notify.order:stock_is_full_delivery'] = "Não podes entregar o pedido porque há demasiados veículos no stock.",
        ['notify.order:max_selected'] = "Selecionaste o número máximo de veículos para encomendar.",
        
        ['notify.employees:no_players_around'] = "Não há jogadores por aqui.",
        ['notify.employees:player_is_offline'] = "Não podes fazer isto, o jogador não está disponível.",
        ['notify.employees:player_is_too_far_away'] = "O jogador está longe demais para ser contratado.",
        ['notify.employees:player_is_already_employed'] = "Este jogador já é um funcionário nesta loja.",
        ['notify.employees:player_is_not_employed'] = "Este jogador não é um funcionário desta loja.",
        ['notify.employees:must_be_unemployed'] = "Este jogador já está empregado noutro lugar.",
        ['notify.employees:you_employee_hired'] = "Contratou-se um novo funcionário!",
        ['notify.employees:awarded_bonus'] = "Concedeste um bónus de %s$ a um funcionário.",
        ['notify.employees:received_bonus'] = "Recebeste um bónus de %s$ da loja onde trabalhas.",
        
        ['notify.balance:withdraw'] = "Retiraste %s$ dos fundos da empresa.",
        ['notify.balance:deposit'] = "Depositaste %s$ no cofre da empresa.",
        ['notify.balance:you_dont_have_that_money'] = "Não tens tanto dinheiro...",
        ['notify.balance:store_dont_have_that_money'] = "O concessionário não tem tanto dinheiro...",
        
        ['notify.sell:cant_resell_to_yourself'] = "Não podes vender um veículo a ti próprio.",
        ['notify.sell:not_enought_money'] = "Não tens dinheiro suficiente para comprar este veículo.",
        ['notify.sell:you_sold_vehicle_with_percent'] = "Vendeste %s veículo %s por %s$ e recebeste %s$ pela venda.",
        ['notify.sell:you_sold_vehicle'] = "Vendeste %s veículo %s por %s$.",
        ['notify.sell:purchased_vehicle'] = "Compraste um %s %s por %s$.",
        
        ['notify.testdrive:no_money'] = "Não tens dinheiro suficiente para testar o veículo.",
        ['notify.testdrive:area_is_occupied'] = "O espaço para test drive está atualmente ocupado.",
        
        ['notify.purchase:success'] = "Parabéns!<br>Compraste um novo veículo: %s %s por %s$.",
        ['notify.purchase:you_dont_have_license'] = "Não tens a licença necessária.",
        ['notify.purchase:you_dont_have_money'] = "Não tens dinheiro para este veículo.",
        ['notify.purchase:dealership_doesnt_have_it_in_stock'] = "A concessionária não tem em estoque no momento.",
        ['notify.purchase:go_to_dealer'] = "Você não pode comprar um veículo, vá falar com um funcionário da concessionária.",
        
        ['help.showroom'] = "~INPUT_CONTEXT~ Salão de exposição %s",
        ['help.contract'] = "~INPUT_CONTEXT~ Assinar o contrato",
        ['help.management'] = "~INPUT_CONTEXT~ Gestão",
        
        ['3dtext.showroom'] = "~g~[E]~s~ Salão de exposição<br>%s",
        ['3dtext.contract'] = "~g~[E]~s~ Assinar o contrato",
        ['3dtext.management'] = "~y~[E]~s~ Gestão",
        
        ['target.showroom'] = "Salão de exposição %s",
        ['target.contract'] = "Assinar o contrato",
        ['target.management'] = "Gestão",
        
        ['announcement.cityhall'] = "Prefeitura"
    },
    ['CZ'] = {
        ['notify.you_are_not_owner'] = "Nevlastnite zadny obchod. Nejste Majitel",

        ['notify.order:trailer_unattached'] = "Naves byl odpojen, pripoj ho",
        ['notify.order:trailer_attached'] = "Naves byl pripojen, pokracuj",
        ['notify.order:trailer_destroyed'] = "Naves byl znicen, vrat ho do obchodu",
        
        ['notify.order:area_is_occupied'] = "Dodaci Misto pred obchodem je obsazene, musis pockat, at se uvolni",
        ['notify.order:not_enought_budget_for_accept'] = "Prodejce Vozidel nema penize na tuto objednavku",
        ['notify.order:order_was_made'] = "Vozidlo jsi sis jiz objednal, nyni si ho muzes vyzvednout",
        ['notify.order:reward_for_delivery'] = "Zapplatil jsi %s$ za doruceni",
        ['notify.order:already_accepted_by_you'] = "Tato objednavka byla prijata tebou",
        ['notify.order:already_accepted_other'] = "Tato objednavka byla prijata jinou osobou",
        ['notify.order:stock_is_full'] = "Nemuzes tuto objednavku prijmout, na sklade je hodne vozidel.",
        ['notify.order:stock_is_full_delivery'] = "Nemuzes tuto objednavku dorucit, na sklade je hodne vozidel.",
        ['notify.order:max_selected'] = "Zvolil jsi prilis velky pocet na objednani vozidel",

        ['notify.employees:no_players_around'] = "Zadny hrac okolo.",
        ['notify.employees:player_is_offline'] = "Nemuzes toto aktualne udelat, hrac neni napojen.",
        ['notify.employees:player_is_too_far_away'] = "Hrac je prilis daleko",
        ['notify.employees:player_is_already_employed'] = "Hrac uz je zamestnancem obchodu",
        ['notify.employees:player_is_not_employed'] = "Hrac neni zamestnancem obchodu",
        ['notify.employees:must_be_unemployed'] = "Hrac uz je nekde zamestnan.",
        ['notify.employees:you_employee_hired'] = "Hrac byl najmut!",
        ['notify.employees:awarded_bonus'] = "Udelil jsi $%s jako premie pro zamestnance.",
        ['notify.employees:received_bonus'] = "Obdrzel jsi premie $%s z obchodu, ve kterem pracujes.",

        ['notify.balance:withdraw'] = "Vybral jsi $%s z kasy Firmy",
        ['notify.balance:deposit'] = "Vlozil jsi $%s Do Firemniho safu",
        ['notify.balance:you_dont_have_that_money'] = "Nemate tolik penez...",
        ['notify.balance:store_dont_have_that_money'] = "Prodejce nema tolik penez...",

        ['notify.sell:cant_resell_to_yourself'] = "Nemuzes prodat vozidlo sam sobe.",
        ['notify.sell:not_enought_money'] = "Nemas dostatek penez pro nakup tohohle vozidla.",
        ['notify.sell:you_sold_vehicle_with_percent'] = "Prodal jsi %s %s vozidlo za %s$ a obdrzel jsi %s$ z prodeje.",
        ['notify.sell:you_sold_vehicle'] = "Prodal jsi %s %s vozidlo za %s$.",
        ['notify.sell:purchased_vehicle'] = "Zakoupil jsi %s %s za %s$.",

        ['notify.testdrive:no_money'] = "Nemate dostatek penez na otestovani",
        ['notify.testdrive:area_is_occupied'] = "Misto pro zkusebni jizdu je obsazeny",

        ['notify.purchase:success'] = "Gratuluji!<br>Zakoupil jsi si: %s %s for $%s.",
        ['notify.purchase:you_dont_have_license'] = "Nemate pozadovanou licenci.",
        ['notify.purchase:you_dont_have_money'] = "Nemate dostatek penez na toto vozidlo.",
        ['notify.purchase:dealership_doesnt_have_it_in_stock'] = "Obchod s vozidly to momentálně nemá skladem.",
        ['notify.purchase:go_to_dealer'] = "Nemůžete koupit vozidlo, jděte za zaměstnancem obchodu s vozidly.",

        ['help.showroom'] = "~INPUT_CONTEXT~ Showroom %s",
        ['help.contract'] = "~INPUT_CONTEXT~ Podepsat Smlouvu",
        ['help.management'] = "~INPUT_CONTEXT~ Vedeni",

        ['3dtext.showroom'] = "~g~[E]~s~ Showroom<br>%s",
        ['3dtext.contract'] = "~g~[E]~s~ Podepsat Smlouvu",
        ['3dtext.management'] = "~y~[E]~s~ Vedeni",

        ['target.showroom'] = "Showroom %s",
        ['target.contract'] = "Podepsat Smlouvu",
        ['target.management'] = "Vedeni",

        ['announcement.cityhall'] = "Městský úřad"
    },
    ['IT'] = {
        ['notify.you_are_not_owner'] = "Non possiedi il negozio, non puoi farlo.",

        ['notify.order:trailer_unattached'] = "Il rimorchio è stato sganciato, attaccalo di nuovo.",
        ['notify.order:trailer_attached'] = "Il rimorchio è stato riattaccato, procedi con la guida.",
        ['notify.order:trailer_destroyed'] = "Il rimorchio è stato distrutto, torna al negozio.",
        
        ['notify.order:area_is_occupied'] = "Lo spazio di consegna di fronte al concessionario è occupato, devi aspettare finché non si libera.",
        ['notify.order:not_enought_budget_for_accept'] = "Il budget del concessionario non permette di accettare questo ordine.",
        ['notify.order:order_was_made'] = "Hai effettuato l'ordine del veicolo, ora puoi andare a ritirarlo.",
        ['notify.order:reward_for_delivery'] = "Ti è stato pagato %s$ per la consegna.",
        ['notify.order:already_accepted_by_you'] = "Questo ordine è già stato accettato da te.",
        ['notify.order:already_accepted_other'] = "Questo ordine è già stato accettato da un altro dipendente.",
        ['notify.order:stock_is_full'] = "Non puoi accettare l'ordine perché ci sono troppi veicoli in magazzino.",
        ['notify.order:stock_is_full_delivery'] = "Non puoi consegnare l'ordine perché ci sono troppi veicoli in magazzino.",
        ['notify.order:max_selected'] = "Hai selezionato il numero massimo di veicoli da ordinare.",

        ['notify.employees:no_players_around'] = "Nessun giocatore intorno.",
        ['notify.employees:player_is_offline'] = "Non puoi farlo, il giocatore non è disponibile.",
        ['notify.employees:player_is_too_far_away'] = "Il giocatore è troppo lontano per essere assunto",
        ['notify.employees:player_is_already_employed'] = "Questo giocatore è già un dipendente di questo negozio.",
        ['notify.employees:player_is_not_employed'] = "Questo giocatore non è un dipendente di questo negozio",
        ['notify.employees:must_be_unemployed'] = "Questo giocatore è già impiegato altrove.",
        ['notify.employees:you_employee_hired'] = "È stato assunto un nuovo dipendente!",
        ['notify.employees:awarded_bonus'] = "Hai assegnato un bonus di $%s a un dipendente.",
        ['notify.employees:received_bonus'] = "Hai ricevuto un bonus di $%s dal negozio in cui lavori.",

        ['notify.balance:withdraw'] = "Hai prelevato $%s dai fondi aziendali",
        ['notify.balance:deposit'] = "Hai depositato $%s nel portavalori dell'azienda.",
        ['notify.balance:you_dont_have_that_money'] = "Non hai così tanti soldi...",
        ['notify.balance:store_dont_have_that_money'] = "Il concessionario non ha così tanti soldi...",

        ['notify.sell:cant_resell_to_yourself'] = "Non puoi rivendere un veicolo a te stesso.",
        ['notify.sell:not_enought_money'] = "Non hai abbastanza soldi per acquistare questo veicolo.",
        ['notify.sell:you_sold_vehicle_with_percent'] = "Hai venduto %s veicolo %s per %s$ e hai ricevuto %s$ dalla vendita.",
        ['notify.sell:you_sold_vehicle'] = "Hai venduto %s veicolo %s per %s$.",
        ['notify.sell:purchased_vehicle'] = "Hai acquistato un %s veicolo %s per %s$.",

        ['notify.testdrive:no_money'] = "Non hai abbastanza soldi per provare il veicolo.",
        ['notify.testdrive:area_is_occupied'] = "Lo spazio per il test drive è attualmente occupato.",

        ['notify.purchase:success'] = "Congratulazioni!<br>Hai acquistato un nuovo veicolo: %s %s per $%s.",
        ['notify.purchase:you_dont_have_license'] = "Non hai la patente necessaria.",
        ['notify.purchase:you_dont_have_money'] = "Non hai abbastanza soldi per questo veicolo.",

        ['help.showroom'] = "~INPUT_CONTEXT~ Sala mostra %s",
        ['help.contract'] = "~INPUT_CONTEXT~ Firma il contratto",
        ['help.management'] = "~INPUT_CONTEXT~ Gestione",

        ['3dtext.showroom'] = "~g~[E]~s~ Sala mostra<br>%s",
        ['3dtext.contract'] = "~g~[E]~s~ Firma il contratto",
        ['3dtext.management'] = "~y~[E]~s~ Gestione",

        ['target.showroom'] = "Sala mostra %s",
        ['target.contract'] = "Firma il contratto",
        ['target.management'] = "Gestione",
        
        ['announcement.cityhall'] = "Municipio"
    },
    ['NL'] = {
        ['notify.you_are_not_owner'] = "Je bezit de winkel niet, je kan dit niet doen.",

        ['notify.order:trailer_unattached'] = "De aanhanger is los gemaakt, maak de trailer vast.",
        ['notify.order:trailer_attached'] = "De aanhanger zit weer vast, rij rustig verder.",
        ['notify.order:trailer_destroyed'] = "De aanhanger is verwoest, ga terug naar de winkel.",
        
        ['notify.order:area_is_occupied'] = "De aflever plek aan de voorkant van de auto winkel is bezet, je moet wachten tot er weer plek vrij is.",
        ['notify.order:not_enought_budget_for_accept'] = "Het budget van de autowinkel is niet genoeg om deze order te maken.",
        ['notify.order:order_was_made'] = "Je hebt jouw voertuig bestelling gedaan, je kan hem nu ophalen.",
        ['notify.order:reward_for_delivery'] = "Je kreeg %s$ betaald voor het bezorgen.",
        ['notify.order:already_accepted_by_you'] = "Deze bestelling is al geaccepteerd door jou.",
        ['notify.order:already_accepted_other'] = "Deze bestelling is al door een andere medewerker aangenomen.",
        ['notify.order:stock_is_full'] = "Je kan de bestelling niet accepteren, omdat er te veel voertuigen in de voorraad zijn.",
        ['notify.order:stock_is_full_delivery'] = "Je kan de bestelling niet bestellen, omdat er te veel voertuigen in de voorraad zijn.",
        ['notify.order:max_selected'] = "Je hebt een maximale aantal voertuigen dat je kan bestellen geselecteerd.",

        ['notify.employees:no_players_around'] = "Geen spelers in de buurt.",
        ['notify.employees:player_is_offline'] = "Je kan dat niet doen, de speler is niet beschikbaar.",
        ['notify.employees:player_is_too_far_away'] = "De speler is te ver weg om aan te nemen.",
        ['notify.employees:player_is_already_employed'] = "Deze speler is al een werknemer in de winkel.",
        ['notify.employees:player_is_not_employed'] = "Deze speler is geen weknemer in de winkel.",
        ['notify.employees:must_be_unemployed'] = "Deze speler is al ergens een werknemer.",
        ['notify.employees:you_employee_hired'] = "Een nieuwe medewerker is aangenomen!",
        ['notify.employees:awarded_bonus'] = "Je hebt een bonus van $%s gegeven aan een medewerker.",
        ['notify.employees:received_bonus'] = "Je ontving een bonus van $%s van de winkel waar je werkt.",

        ['notify.balance:withdraw'] = "Je hebt $%s uit de bedrijfspot gehaald",
        ['notify.balance:deposit'] = "Je hebt $%s in de kluis gelegd.",
        ['notify.balance:you_dont_have_that_money'] = "Je hebt niet zoveel geld...",
        ['notify.balance:store_dont_have_that_money'] = "De auto winkel heeft niet zoveel geld...",

        ['notify.sell:cant_resell_to_yourself'] = "Je kan geen voertuig aan jezelf verkopen.",
        ['notify.sell:not_enought_money'] = "Je hebt niet genoeg geld om dit voertuig te kopen.",
        ['notify.sell:you_sold_vehicle_with_percent'] = "Je hebt een %s %s voertuig verkocht voor %s$ en ontvangt %s$ van de verkoop.",
        ['notify.sell:you_sold_vehicle'] = "je hebt een %s %s voertuig verkocht voor %s$.",
        ['notify.sell:purchased_vehicle'] = "Je hebt een %s %s gekocht voor %s$.",

        ['notify.testdrive:no_money'] = "Je hebt niet genoeg geld om het voertuig te testen.",
        ['notify.testdrive:area_is_occupied'] = "Plek voor de test rit it momenteel bezet.",

        ['notify.purchase:success'] = "Gefeliciteerd!<br>Je hebt een nieuw voertuig gekocht: %s %s for $%s.",
        ['notify.purchase:you_dont_have_license'] = "Je hebt niet het juiste rijbewijs.",
        ['notify.purchase:you_dont_have_money'] = "Je hebt geen geld voor dit voertuig.",
        ['notify.purchase:dealership_doesnt_have_it_in_stock'] = "De dealer heeft het momenteel niet op voorraad.",
        ['notify.purchase:go_to_dealer'] = "Je kunt geen voertuig kopen, ga naar een medewerker van de dealer.",

        ['help.showroom'] = "~INPUT_CONTEXT~ Showroom %s",
        ['help.contract'] = "~INPUT_CONTEXT~ Teken het contract",
        ['help.management'] = "~INPUT_CONTEXT~ Management",

        ['3dtext.showroom'] = "~g~[E]~s~ Showroom<br>%s",
        ['3dtext.contract'] = "~g~[E]~s~ Teken het contract",
        ['3dtext.management'] = "~y~[E]~s~ Management",

        ['target.showroom'] = "Showroom %s",
        ['target.contract'] = "Teken het contract",
        ['target.management'] = "Management",

        ['announcement.cityhall'] = "Stadhuis"
    },
    ['PL'] = {
        ['notify.you_are_not_owner'] = "Nie jesteś właścicielem salonu, nie możesz tego zrobić.",

        ['notify.order:trailer_unattached'] = "Przyczepa została odczepiona, podłącz przyczepę.",
        ['notify.order:trailer_attached'] = "Przyczepa została ponownie podłączona, jedź dalej.",
        ['notify.order:trailer_destroyed'] = "Przyczepa została zniszczona, wróć do salonu.",
        
        ['notify.order:area_is_occupied'] = "Przestrzeń dostawy przed salonem jest zajęta, musisz poczekać, aż zostanie zwolniona.",
        ['notify.order:not_enought_budget_for_accept'] = "Budżet salonu nie pozwala na złożenie tego zamówienia.",
        ['notify.order:order_was_made'] = "Złożyłeś zamówienie na pojazdy, teraz możesz przejść po jego odbiór.",
        ['notify.order:reward_for_delivery'] = "Otrzymałeś %s$ za dostarczenie.",
        ['notify.order:already_accepted_by_you'] = "To zamówienie zostało już przez ciebie zaakceptowane.",
        ['notify.order:already_accepted_other'] = "To zamówienie zostało już zaakceptowane przez innego pracownika.",
        ['notify.order:stock_is_full'] = "Nie możesz zaakceptować zamówienia, ponieważ w magazynie jest za dużo pojazdów.",
        ['notify.order:stock_is_full_delivery'] = "Nie możesz dostarczyć zamówienia, ponieważ w magazynie jest zbyt wiele pojazdów.",
        ['notify.order:max_selected'] = "Wybrałeś maksymalną liczbę pojazdów do zamówienia.",

        ['notify.employees:no_players_around'] = "Brak graczy w pobliżu.",
        ['notify.employees:player_is_offline'] = "Nie możesz tego zrobić, gracz jest niedostępny.",
        ['notify.employees:player_is_too_far_away'] = "Gracz jest zbyt daleko, aby go zatrudnić.",
        ['notify.employees:player_is_already_employed'] = "Ten gracz już pracuje jako pracownik w tym salonie.",
        ['notify.employees:player_is_not_employed'] = "Ten gracz nie jest pracownikiem tego salonu.",
        ['notify.employees:must_be_unemployed'] = "Ten gracz już pracuje gdzieś indziej.",
        ['notify.employees:you_employee_hired'] = "Zatrudniono nowego pracownika!",
        ['notify.employees:awarded_bonus'] = "Przyznano premię w wysokości $%s dla pracownika.",
        ['notify.employees:received_bonus'] = "Otrzymano premię w wysokości $%s z salonu w którym pracujesz.",

        ['notify.balance:withdraw'] = "Wypłaciłeś $%s z funduszy firmy.",
        ['notify.balance:deposit'] = "Wpłaciłeś $%s do sejfu firmy.",
        ['notify.balance:you_dont_have_that_money'] = "Nie masz tyle pieniędzy...",
        ['notify.balance:store_dont_have_that_money'] = "Salon nie ma tyle pieniędzy...",

        ['notify.sell:cant_resell_to_yourself'] = "Nie możesz sprzedać pojazdu sobie.",
        ['notify.sell:not_enought_money'] = "Nie masz wystarczająco pieniędzy, aby dokonać zakupu tego pojazdu.",
        ['notify.sell:you_sold_vehicle_with_percent'] = "Sprzedałeś %s %s pojazd za %s$ i otrzymałeś %s$ za sprzedaż.",
        ['notify.sell:you_sold_vehicle'] = "Sprzedałeś %s %s pojazd za %s$.",
        ['notify.sell:purchased_vehicle'] = "Zakupiłeś %s %s za %s$.",

        ['notify.testdrive:no_money'] = "Nie masz wystarczająco pieniędzy, aby przetestować pojazd.",
        ['notify.testdrive:area_is_occupied'] = "Przestrzeń na jazdę testową jest obecnie zajęta.",
        
        ['notify.purchase:success'] = "Gratulacje!<br>Zakupiłeś nowy pojazd: %s %s za %s$.",
        ['notify.purchase:you_dont_have_license'] = "Nie masz wymaganego zezwolenia.",
        ['notify.purchase:you_dont_have_money'] = "Nie masz wystarczająco pieniędzy na ten pojazd.",       
        ['notify.purchase:dealership_doesnt_have_it_in_stock'] = "Dealer nie ma obecnie tego pojazdu na stanie.",
        ['notify.purchase:go_to_dealer'] = "Nie możesz kupić pojazdu, udaj się do pracownika salonu samochodowego.",

        ['help.showroom'] = "~INPUT_CONTEXT~ Showroom %s",
        ['help.contract'] = "~INPUT_CONTEXT~ Podpisz umowę",
        ['help.management'] = "~INPUT_CONTEXT~ Zarządzanie",

        ['3dtext.showroom'] = "~g~[E]~s~ Showroom<br>%s",
        ['3dtext.contract'] = "~g~[E]~s~ Podpisz umowę",
        ['3dtext.management'] = "~y~[E]~s~ Zarządzanie",

        ['target.showroom'] = "Showroom %s",
        ['target.contract'] = "Podpisz umowę",
        ['target.management'] = "Zarządzanie",

        ['announcement.cityhall'] = "Urząd Skarbowy"
    },
}

TRANSLATE = function(name, ...)
    if Config.Translate[Config.Language] then
        if ... then
            return Config.Translate[Config.Language][name]:format(...)
        else
            return Config.Translate[Config.Language][name]
        end
    else
        if ... then
            return Config.Translate['EN'][name]:format(...)
        else
            return Config.Translate['EN'][name]
        end
    end
end
