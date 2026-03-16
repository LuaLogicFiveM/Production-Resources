let translation = {};

let isMenuOpened = false;
let isBasketVisible = false;

let currentMenu = null;
let selectedOption = null;

let productsLabels = {};
let ordersLimit = 1;

let wholesales = {};

let storeCfg = {};
let storeData = {};

let employees = {};

let executionTime = {};
let alarmPrice = 0;
let moneyEscortPrice = 0; 
let insurances = {};
let levelsBenefits = {};
let sellPercentage = 0; 
let useCamera = false; 
let abilityChangeProductsPrices = false;

let isEmployee = false;
let isManager = false;
let isBoss = false;
let cityhallGrades = false;

let useCityHall = false;
let useCityHallResumes = false;
let useCityHallTaxes = false;
let taxBusinessAllowMakeDelayedDeclarations = false;
let taxBusinessPercentagePerMonthForDelay = false;


let playerName = "";
let currentDate = "";

var number = Intl.NumberFormat('en-US', {minimumFractionDigits: 0});

const formatDate = (timestamp) => {
    const date = new Date((Number(timestamp) * 1000));
    let hour = date.getHours();
    let minute = date.getMinutes();
    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();
    if (hour < 10) hour = '0' + hour
    if (minute < 10) minute = '0' + minute
    if (day < 10) day = '0' + day
    if (month < 10) month = '0' + month
    
    return day + '.' + month + '.' + year + ' ' + hour + ':' + minute
};

String.prototype.format = function() {
    var formatted = this;
    for (var i = 0; i < arguments.length; i++) {
        var regexp = new RegExp('\\{'+i+'\\}', 'gi');
        formatted = formatted.replace(regexp, arguments[i]);
    }
    return formatted;
};

window.addEventListener("load", function() {
    $.post('https://vms_stores/loaded')
});

window.addEventListener('message', function(event){
    var item = event.data;
    if (item.action == "loaded") {
        executionTime = item.executionTime;
        alarmPrice = item.alarmPrice;
        moneyEscortPrice = item.moneyEscortPrice;
        insurances = item.insurances;
        levelsBenefits = item.levelsBenefits;
        sellPercentage = item.sellPercentage;
        wholesales = item.wholesales;
        useCamera = item.useCamera;
        abilityEmployeesToCreateOrders = item.abilityEmployeesToCreateOrders;
        abilityChangeProductsPrices = item.abilityChangeProductsPrices;
        
        useCityHall = item.useCityHall;
        useCityHallResumes = item.useCityHallResumes;
        useCityHallTaxes = item.useCityHallTaxes;
        useCityHallIncludedTaxes = item.useCityHallIncludedTaxes;

        taxBusinessAllowMakeDelayedDeclarations = item.taxBusinessAllowMakeDelayedDeclarations;
        taxBusinessPercentagePerMonthForDelay = item.taxBusinessPercentagePerMonthForDelay;

        let lang = item.lang
        $.ajax({
            url: '../config/translation.json',
            type: 'GET',
            dataType: 'json',
            success: function (code, statut) {
                translation = code[lang]

                // Intimidation Translation:
                $('.intimidation-bar > .text').text(translation.intimidation);

                // Receipt Translation:
                $('.receipt > .receipt-texts .item').text(translation.receipt.item);
                $('.receipt > .receipt-texts .amount').text(translation.receipt.amount);
                $('.receipt > .receipt-texts .total > div:first-child').text(translation.receipt.total);
                $('.receipt > .receipt-texts .pay_cash').text(translation.receipt.pay_cash);
                $('.receipt > .receipt-texts .pay_bank').text(translation.receipt.pay_bank);
                $('.receipt > .receipt-texts .cancel').text(translation.receipt.cancel);
                                
                // Basket Translation:
                $('.basket-menu .header-name span').text(translation.basket.your_basket);
                
                $('.basket-menu .help #press').text(translation.basket.help_press);
                $('.basket-menu .help .key').text(translation.basket.help_key);
                $('.basket-menu .help #manage').text(translation.basket.help_manage);
                // Shelf Translation:
                $('.select-products .header-name span').text(translation.shelf.select_products);
                $('.select-products .hide-help > #press').text(translation.shelf.help_hide_menu1);
                $('.select-products .hide-help > .key').text(translation.shelf.help_hide_menu_key);
                $('.select-products .hide-help > #to_hide').text(translation.shelf.help_hide_menu2);
                
                // Management Translation:
                $('.management-menu .side-bar div[data-href="main"] .title').text(translation.sidebar.main_title);
                $('.management-menu .side-bar div[data-href="main"] .description').text(translation.sidebar.main_description);
                $('.management-menu .side-bar div[data-href="stock"] .title').text(translation.sidebar.stock_title);
                $('.management-menu .side-bar div[data-href="stock"] .description').text(translation.sidebar.stock_description);
                $('.management-menu .side-bar div[data-href="order"] .title').text(translation.sidebar.order_title);
                $('.management-menu .side-bar div[data-href="order"] .description').text(translation.sidebar.order_description);
                $('.management-menu .side-bar div[data-href="employees"] .title').text(translation.sidebar.employees_title);
                $('.management-menu .side-bar div[data-href="employees"] .description').text(translation.sidebar.employees_description);
                $('.management-menu .side-bar div[data-href="upgrade"] .title').text(translation.sidebar.upgrade_title);
                $('.management-menu .side-bar div[data-href="upgrade"] .description').text(translation.sidebar.upgrade_description);
                $('.management-menu .side-bar div[data-href="boss-management"] .title').text(translation.sidebar.boss_management_title);
                $('.management-menu .side-bar div[data-href="boss-management"] .description').text(translation.sidebar.boss_management_description);
                
                // Main:
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .header').text(translation.main.menu_announcements_header);
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .title').text(translation.main.menu_announcements_title);
                $('.management-menu div[data-type="main"] div[data-type="total-sales"] .header').text(translation.main.menu_total_sales_header);
                $('.management-menu div[data-type="main"] div[data-type="total-earned"] .header').text(translation.main.menu_total_earned_header);
                $('.management-menu div[data-type="main"] div[data-type="best-sellers"] .header').text(translation.main.menu_best_sellers_header);

                // Orders:
                $('.management-menu div[data-type="order"] .header').text(translation.order.menu_order_header);
                $('.management-menu div[data-type="order"] .title').text(translation.order.menu_order_title);
                $('.management-menu div[data-type="order"] div[data-option="make-order"] p').text(translation.order.menu_order_btn);
                $('.management-menu div[data-type="order"] form label[for="select-wholesale"]').text(translation.order.select_wholesale_header);
                $('.management-menu div[data-type="order"] form label[for="select-product"]').text(translation.order.select_product_header);
                $('.management-menu div[data-type="order"] form label[for="select-product2"]').text(translation.order.select_product_header);
                $('.management-menu div[data-type="order"] form label[for="select-product3"]').text(translation.order.select_product_header);
                $('.management-menu div[data-type="order"] .orders-list #orders-table thead tr th span#wholesale').text(translation.order.table_wholesale);
                $('.management-menu div[data-type="order"] .orders-list #orders-table thead tr th span#product').text(translation.order.table_product);
                $('.management-menu div[data-type="order"] .orders-list #orders-table thead tr th span#orderprice').text(translation.order.table_orderprice);
                $('.management-menu div[data-type="order"] .orders-list #orders-table thead tr th span#option').text(translation.order.table_option);
                
                let selectWholesale = `<option value="">${translation.order.select_option}</option>`
                const wholesaleKeys = Object.keys(wholesales).sort();
                for (const key of wholesaleKeys) {
                    const value = wholesales[key];
                    selectWholesale += `<option value="${key}">${value.label}</option>`;
                }
                $('div[data-type="order"] form #select-wholesale').html(selectWholesale)

                // Employees:
                $('.management-menu div[data-type="employees"] .header').text(translation.employees.menu_employees_header);
                $('.management-menu div[data-type="employees"] .title').text(translation.employees.menu_employees_title);
                $('.management-menu div[data-type="employees"] .btn[data-option="get_closest_players"] p').text(translation.employees.menu_employees_btn);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#employee').text(translation.employees.table_employee);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#orders').text(translation.employees.table_orders);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#grade').text(translation.employees.table_grade);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#option').text(translation.employees.table_option);

                // Management:
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] .header').text(translation.management.menu_balance_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] div[data-option="withdraw"] p').text(translation.management.menu_balance_btn_withdraw);
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] div[data-option="deposit"] p').text(translation.management.menu_balance_btn_deposit);
                $('.management-menu div[data-type="boss-management"] div[data-type="employees-count"] .header').text(translation.management.menu_employees_header);
                $('.management-menu div[data-type="boss-management"] div[data-option="employees"] p').text(translation.management.menu_employees_btn_manage);

                $('.management-menu div[data-type="boss-management"] div[data-type="upgrade-menu"] .header').text(translation.management.menu_upgrade_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="upgrade-menu"] .title').text(translation.management.menu_upgrade_title);
                $('.management-menu div[data-type="boss-management"] div[data-type="upgrade-menu"] .btn p').text(translation.management.menu_upgrade_btn_open);
                $('.management-menu div[data-type="boss-management"] div[data-type="send-announcement"] .header').text(translation.management.menu_announcement_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="send-announcement"] .title').text(translation.management.menu_announcement_title);
                $('.management-menu div[data-type="boss-management"] div[data-type="send-announcement"] .btn p').text(translation.management.menu_announcement_btn_send);
                $('.management-menu div[data-type="boss-management"] div[data-type="money-escort"] .header').text(translation.management.menu_moneyescort_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="money-escort"] .title').text(translation.management.menu_moneyescort_title);
                $('.management-menu div[data-type="boss-management"] div[data-type="money-escort"] .btn p').text((translation.management.menu_moneyescort_btn_order).format(number.format(moneyEscortPrice), translation.currency));
                $('.management-menu div[data-type="boss-management"] div[data-type="sell"] .header').text(translation.management.menu_sell_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="sell"] .title').text(translation.management.menu_sell_title);
                $('.management-menu div[data-type="boss-management"] div[data-type="resell"] .header').text(translation.management.menu_resell_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="resell"] .title').text(translation.management.menu_resell_title);
                $('.management-menu div[data-type="boss-management"] div[data-type="resell"] .btn > p').text(translation.management.menu_resell_btn);

                // Upgrade:
                $('.management-menu div[data-type="upgrade"] div[data-type="level"] .header').text(translation.upgrade.menu_level_header);                
                $('.management-menu div[data-type="upgrade"] div[data-type="level"] .btn[data-option="levelup"] p').text(translation.upgrade.menu_level_btn);                
                $('.management-menu div[data-type="upgrade"] div[data-type="levelinfo"] .header').text(translation.upgrade.menu_levelinfo_header);
                $('.management-menu div[data-type="upgrade"] div[data-type="levelinfo"] .title').text(translation.upgrade.menu_levelinfo_title);
                $('.management-menu div[data-type="upgrade"] div[data-type="alarm"] .header').text(translation.upgrade.menu_alarm_header);
                $('.management-menu div[data-type="upgrade"] div[data-type="alarm"] .title').text(translation.upgrade.menu_alarm_title);
                $('.management-menu div[data-type="upgrade"] div[data-type="insurance"] .header').text(translation.upgrade.menu_insurance_header);
                $('.management-menu div[data-type="upgrade"] div[data-type="insurance"] .title').text(translation.upgrade.menu_insurance_title);

                // Purchase Business Translation:
                $('.buy-business .header-name span').text(translation.buy_business.header);

                let purchaseMenuData = `<span>${translation.buy_business.important_infos}</span>`;
                for (const [key, value] of Object.entries(config.purchaseInformations)) {
                    purchaseMenuData += `
                        <div>
                            <span>${value.title}</span>
                            <div>${value.description}</div>
                        </div>
                    `
                }
                $('.buy-business .info-business > .informations').html(purchaseMenuData);

                $('.resell .card .paragraph > b').html(translation.resell_card.paragraph)

                
                if (useCityHall) {
                    let { CityHall_SideBars, CityHall_Menus } = window.mySharedFunction();
                    
                    $('.management-menu > .menu > .side-bar').append(`
                        ${useCityHallResumes ? (CityHall_SideBars.resumes).format(translation.sidebar.resumes_title, translation.sidebar.resumes_description) : ''}
                        ${useCityHallTaxes ? (CityHall_SideBars.taxes).format(translation.sidebar.taxes_title, translation.sidebar.taxes_description) : ''}
                    `)
    
                    $('.management-menu > .menu > .main').append(`
                        ${useCityHallResumes ? (CityHall_Menus.resumes).format(
                            translation.resumes.list_header,
                            translation.resumes.list_title,
    
                            translation.resumes.table_citizen,
                            translation.resumes.table_date,
                            translation.resumes.table_option,
    
                            translation.resumes.manage_header,
                            translation.resumes.manage_title,
    
                            translation.resumes.manage_description,
                            translation.resumes.manage_toggle_btn,
                        ) : ''}

                        ${useCityHallTaxes ? (CityHall_Menus.taxes).format(
                            translation.taxes.taxes_header,
                            translation.taxes.taxes_title
                        ) : ''}
                    `)
                }
            }
        });
    } else if (item.action == "updateBasket") {
        if (item.type == "show") {
            isBasketVisible = true
            $(".basket-menu").show();
            $(".basket-menu").addClass("isBasketVisible").removeClass("isBasketInvisible")
        } else if (item.type == "hide") {
            isBasketVisible = false
            $(".basket-menu").addClass("isBasketInvisible").removeClass("isBasketVisible")
        } else if (item.type == "added") {
            if (!isBasketVisible) {
                isBasketVisible = true
                $(".basket-menu").show();
                $(".basket-menu").addClass("isBasketVisible").removeClass("isBasketInvisible")
            }
            let htmlData = ``
            for (const [key, value] of Object.entries(item.items)) {
                htmlData = htmlData + `
                    <div data-name="${key}">
                        <div class="product">
                            <p class="count">${value.count}${key == 'fuel' && translation.liters || translation.quantity}</p>
                            <p class="label">${value.label}</p>
                        </div>
                        <div class="remove" onclick="removeFromBasket('${key}')">
                            <i class="fas fa-close"></i>
                        </div>
                    </div>
                `
            }
            $(".basket-menu .options").html(htmlData)
            $(".basket-menu .total-price").html(`${translation.basket.total_price} <span>${translation.currency}${number.format(item.totalPrice)}</span>`)
        } else if (item.type == "clear") {
            $(".basket-menu .options").empty();
            $(".basket-menu .total-price").html(`${translation.basket.total_price} <span>${translation.currency}0</span>`)
        }
    } else if (item.action == "openProductsMenu") {
        let possibleProducts = item.possibleProducts;
        let stock = item.stock;
        let htmlData = ''
        currentMenu = 'products';
        $('.select-products .products-list').empty();
        for (const [key, value] of Object.entries(item.items)) {
            if (possibleProducts[value.name]) {
                let price = value.taxPercentage && (
                    !useCityHallIncludedTaxes && (
                        (abilityChangeProductsPrices && stock && stock[value.name] && stock[value.name].price && (
                            stock[value.name].price + (stock[value.name].price * (value.taxPercentage / 100))
                        )) || value.priceWithTax
                    ) || (abilityChangeProductsPrices && stock && stock[value.name] && stock[value.name].price || value.price)
                ) || (abilityChangeProductsPrices && stock && stock[value.name] && stock[value.name].price || value.price);

                price = Math.floor(price);

                htmlData = htmlData + `
                    <div class="product">
                        <div class="info">
                            <div class="label">${value.label}</div>
                            <div class="price">${translation.currency}${number.format(price)}</div>
                        </div>
                        <div class="icon">
                            ${config.iconsCustomPath && `
                                <img src="${config.iconsCustomPath}${value.name}.png" draggable="false">
                            ` || `
                                <img src="products-icons/${value.name}.png" draggable="false">
                            `}
                        </div>
                        ${stock && (stock[value.name] && stock[value.name].count != undefined && stock[value.name].count >= 1 && `
                            <div class="stock-count">${translation.shelf.stock_count} ${stock[value.name].count}${translation.quantity}</div>
                            <div class="actions">
                                <input min="1" max="100" data-name="${value.name}" type="number" value="1" onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : event.charCode >= 48 && event.charCode <= 57">
                                <div class="add-to-cart" onclick="addToCart('${value.name}', '${item.shelf}')">${translation.shelf.add_to_cart}</div>
                            </div>
                        ` || `
                            <div class="actions">
                                <div class="not-in-stock">${translation.shelf.not_in_stock}</div>
                            </div>
                        `) || `
                            <div class="actions">
                                <input min="1" max="100" data-name="${value.name}" type="number" value="1" onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : event.charCode >= 48 && event.charCode <= 57">
                                <div class="add-to-cart" onclick="addToCart('${value.name}', '${item.shelf}')">${translation.shelf.add_to_cart}</div>
                            </div>
                        `}
                    </div>
                `
            }
        }

        $('.select-products .products-list').html(htmlData);
        $('.select-products').show(120);
    } else if (item.action == "openManagementMenu") {
        playerName = item.playerName;
        isEmployee = item.isEmployee;
        isManager = item.isManager;
        isBoss = item.isBoss;
        cityhallGrades = item.cityhallGrades;

        ordersLimit = item.ordersLimit;
        productsLabels = item.productsLabels
        storeCfg = item.storeCfg
        storeData = item.storeData
        employees = item.employees
        
        // Main Menu - loader:
        $('.management-menu .header .store-name').html(`${storeCfg.brand} <span>${storeCfg.address}</span>`)

        if (item.isManager || item.isBoss) {
            $('.management-menu .menu .side-bar div[data-href="upgrade"]').show();
            $('.management-menu .menu .side-bar div[data-href="boss-management"]').show();
            $('.management-menu .menu .side-bar div[data-href="employees"]').show();
            $('.management-menu .menu .main div[data-type="order"] .box-right').show()
            $('.management-menu').addClass(item.isManager && 'isManager' || '').removeClass(item.isBoss && 'isManager' || '').removeClass('isEmployee')
        } else {
            $('.management-menu .menu .side-bar div[data-href="upgrade"]').hide();
            $('.management-menu .menu .side-bar div[data-href="boss-management"]').hide();
            $('.management-menu .menu .side-bar div[data-href="employees"]').hide();
            if (!abilityEmployeesToCreateOrders) {
                $('.management-menu').addClass('isEmployee')
                $('.management-menu .menu .main div[data-type="order"] .box-right').hide()
            } else {
                $('.management-menu .menu .main div[data-type="order"] .box-right').show()
            }
        }

        const currentTimestamp = Math.floor(Date.now() / 1000);
        let hoursDifference = 0;
        if (storeData.data.lastActivity) {
            const timeDifference = currentTimestamp - storeData.data.lastActivity;
            hoursDifference = Math.floor(timeDifference / (60 * 60));
        }
        $('.management-menu .menu .main div[data-type="main"] .side-boxes div[data-type="store-status"]').removeClass('important').removeClass('warning').addClass(hoursDifference >= executionTime['critical'] && 'important' || hoursDifference >= executionTime['warning'] && 'warning' || '')
        $('.management-menu .menu .main div[data-type="main"] .side-boxes div[data-type="store-status"] .header').html(hoursDifference >= executionTime['critical'] && (translation.main.menu_status_critical_header).format(hoursDifference) || hoursDifference >= executionTime['warning'] && (translation.main.menu_status_bad_header).format(hoursDifference) || translation.main.menu_status_good_header)
        $('.management-menu .menu .main div[data-type="main"] .side-boxes div[data-type="store-status"] .title').html(hoursDifference >= executionTime['critical'] && translation.main.menu_status_critical_title || hoursDifference >= executionTime['warning'] && translation.main.menu_status_bad_title || translation.main.menu_status_good_title)

        // Announcements - loader:
        let announcementsData = ''
        for (const [k, v] of Object.entries(storeData.announcements)) {
            if (v) {
                announcementsData = announcementsData + `
                    <div ${v.type && `class="${v.type}"` || ''}>
                        <div class="user ${v.type && `${v.type}` || ''}">
                            <div class="avatar"><i class="${!v.type && "fa-solid fa-user" || v.type == "alarm" && "fa-solid fa-bell" || v.type == "insurance" && "fa-solid fa-shield-halved" || v.type == "monitoring" && "fa-solid fa-video"}"></i></div>
                            <div class="name">${v.name}</div>
                        </div>
                        <div class="message">${v.message}</div>
                    </div>
                `
            }
        }
        $('.management-menu div[data-type="main"] div[data-type="announcements"] .announcements-messages').html(announcementsData)

        // Total Sales - loader:
        $('.management-menu div[data-type="main"] div[data-type="total-sales"] .title').html(`${storeData.data.totalSales}`)

        // Total Earned - loader:
        $('.management-menu div[data-type="main"] div[data-type="total-earned"] .title').html(`${translation.currency} ${number.format(storeData.data.totalEarned)}`)

        // Best Sellers - loader:
        //const productsArray = [...Object.entries(storeData.stock.products), storeData.stock.fuel ? ['fuel', storeData.stock.fuel] : []];
        const productsArray = Object.entries(storeData.stock.products);
        productsArray.sort((a, b) => (b[1]?.sold || 0) - (a[1]?.sold || 0));
        const bestsellers = productsArray.slice(0, 8);

        let bestSellersData = ''
        bestsellers.forEach(([k, v]) => {
            if (v || productsLabels[k] != "Fuel") {
                bestSellersData = bestSellersData + `
                    <div>
                        <span class="label">${productsLabels[k]}</span>
                        <span class="count">${v.sold}${translation.quantity}</span>
                    </div>
                `
            }
        })
        $('.management-menu .main div[data-type="main"] .side-boxes div[data-type="best-sellers"] .products-list').html(bestSellersData)

        // Stock - loader:
        let stockData = ''
        /*
        if (storeData.stock.fuel) {
            stockData = stockData + `
                <div class="product ${storeData.stock.fuel.count <= 0 && `lack-of-stock` || ''} ${abilityChangeProductsPrices && (isBoss || isManager) ? 'extended-stock' : ''}">
                    <div class="info">
                        <div class="label">${productsLabels['fuel']}</div>
                    </div>
                    <div class="icon">
                        <img src="products-icons/fuel.png"draggable="false">
                    </div>
                    <div class="information">
                        <div class="stock-data">${translation.stock.stock} <span>${storeData.stock.fuel.count}${translation.liters}</span></div>
                        ${abilityChangeProductsPrices && (isBoss || isManager) ? `
                            <hr>
                            <div class="custom-price">
                                <div>
                                    <span>${translation.stock.set_custom_price}</span>
                                    <span>${storeData.stock.fuel.price ? storeData.stock.fuel.price + translation.currency : translation.stock.default_price}</span>
                                </div>
                                <input type="number" data-item="fuel" onkeyup="checkEnter(this, event)">
                            </div>
                        ` : ''}
                    </div>
                </div>
            `
        }*/
        for (const [k, v] of Object.entries(storeData.stock.products)) {
            if (k) {
                stockData = stockData + `
                    <div class="product ${v.count <= 0 && `lack-of-stock` || ''} ${abilityChangeProductsPrices && (isBoss || isManager) ? 'extended-stock' : ''}">
                        <div class="info">
                            <div class="label">${productsLabels[k]}</div>
                        </div>
                        <div class="icon">
                            ${config.iconsCustomPath && `
                                <img src="${config.iconsCustomPath}${k}.png" draggable="false">
                            ` || `
                                <img src="products-icons/${k}.png" draggable="false">
                            `}
                        </div>
                        <div class="information">
                            <div class="stock-data">${translation.stock.stock} <span>${v.count}${translation.quantity}</span></div>
                            ${abilityChangeProductsPrices && (isBoss || isManager) ? `
                                <hr>
                                <div class="custom-price">
                                    <div>
                                        <span>${translation.stock.set_custom_price}</span>
                                        <span>${v.price ? v.price + translation.currency : translation.stock.default_price}</span>
                                    </div>
                                    <input type="number" data-item="${k}" onkeyup="checkEnter(this, event)">
                                </div>
                            ` : ''}
                        </div>
                    </div>
                `
            }
        }
        $('.management-menu div[data-type="stock"] > div').html(stockData)
        
        // Orders - loader:        
        let ordersData = ''
        for (const [k, v] of Object.entries(storeData.orders)) {
            let products = ''
            let price = 0
            if (v.product) {
                if (wholesales[v.wholesale].fuel) {
                    products = productsLabels[v.product]
                    price = (wholesales[v.wholesale].fuel?.orderPrice && wholesales[v.wholesale].fuel?.orderPrice * v.count || 0.0)
                } else {
                    products = products + productsLabels[v.product] + ' ' + v.count + translation.quantity
                    price += wholesales[v.wholesale].products && Number(wholesales[v.wholesale].products[v.product]?.orderPrice) * Number(v.count) || 0.0
                }
            }
            if (v.product2) {
                if (products != '') products = products + ', ';
                products = products + productsLabels[v.product2] + ' ' + v.count2 + translation.quantity
                price += wholesales[v.wholesale].products && Number(wholesales[v.wholesale].products[v.product2]?.orderPrice) * Number(v.count2) || 0.0
            }
            if (v.product3) {
                if (products != '') products = products + ', ';
                products = products + productsLabels[v.product3] + ' ' + v.count3 + translation.quantity
                price += wholesales[v.wholesale].products && Number(wholesales[v.wholesale].products[v.product3]?.orderPrice) * Number(v.count3) || 0.0
            }
            
            ordersData = ordersData + `
                <tr>
                    <td class="table-first">${translation.order.table_wholesale} ${v.wholesale}</td>
                    <td>${products}</td>
                    <td>${price}${translation.currency}</td>
                    <td class="table-last">
                        ${(storeData.ordersAccepted && storeData.ordersAccepted[k]) ? `<div class="accepted-order">${translation.order.table_option_accepted}</div>` : `<div data-option="accept-order" onclick="acceptOrder('${k}')">${translation.order.table_option_accept}</div>`}
                    </td>
                </tr>
            `
        }
        $('.management-menu div[data-type="order"] tbody').html(ordersData)

        // Employees - loader:
        let employeesData = ''
        for (const [k, v] of Object.entries(employees)) {
            if (storeData.employees[v.identifier || v.empSource]) {
                employeesData = employeesData + `
                    <tr>
                        <td class="table-first">${v.name}</td>
                        <td>${storeData.employees[v.identifier || v.empSource].orders}</td>
                        <td>${v.job ? v.job.grade_label : v.grade.name}</td>
                        <td class="table-last"><div onclick="manageEmployee('${v.name}', '${v.identifier || v.empSource}')">${translation.management.menu_employees_btn_manage}</div></td>
                    </tr>
                `
            }
        }
        $('.management-menu div[data-type="employees"] .box .data').html("")
        $('.management-menu div[data-type="employees"] tbody').html(employeesData)

        // Balance - loader:
        $('.management-menu div[data-type="boss-management"] div[data-type="balance"] .title').html(`${translation.currency} ${number.format(storeData.data.balance)}`)

        // Employees Count - loader:
        $('.management-menu div[data-type="boss-management"] div[data-type="employees-count"] .title').html(`${item.employeesCount}`)

        // Sell price - loader:
        $('.management-menu div[data-type="boss-management"] div[data-type="sell"] .btn > p').text((translation.management.menu_sell_btn).format(number.format((sellPercentage / 100) * storeCfg.price), translation.currency))

        // Upgrade - loader:
        let daysDifference = 0
        if (storeData.data.insurance) {
            const timeDifference = storeData.data.insurance - currentTimestamp;
            daysDifference = Math.floor(timeDifference / (60 * 60 * 24));
        }
        $('.management-menu div[data-type="upgrade"] div[data-type="insurance"] .info').text(storeData.data.insurance ? (translation.upgrade.menu_insurance_info_days).format(daysDifference) : translation.upgrade.menu_insurance_info_none)

        if (storeData.data.alarm) {
            if (useCamera) {
                $('.management-menu div[data-type="upgrade"] div[data-type="alarm"] .buttons').html(`
                    <div class="btn" onclick="checkCameras()">
                        <p>${(translation.upgrade.menu_alarm_check_cameras)}</p>
                    </div>
                `)
            }
        } else {
            $('.management-menu div[data-type="upgrade"] div[data-type="alarm"] .buttons').html(`
                <div class="btn" onclick="buyAlarm()">
                    <p>${(translation.upgrade.menu_alarm_btn).format(number.format(alarmPrice))}</p>
                </div>
            `)
        }
        
        $('.management-menu div[data-type="upgrade"] div[data-type="level"] .title').text((translation.upgrade.menu_level_title).format(storeData.data['level']));
        $('div[data-type="upgrade"] div[data-type="level"] .description').empty();
        if (levelsBenefits[storeData.data['level']].levelup) {
            let levelRequirements = `<span>${translation.upgrade.menu_level_description}</span>`;
            for (const [k, v] of Object.entries(levelsBenefits[storeData.data['level']].levelup)) {
                if (k == 'sell_products') {
                    levelRequirements = levelRequirements + `
                        ${storeData.data.totalSales >= v.count && `<div class="meets"><i class="fa-solid fa-square-check"></i>` || '<div><i class="fa-solid fa-square-xmark"></i>'} ${translation.upgrade.menu_level_requirement_sell_products} ${storeData.data.totalSales}/<span>${v.count}</span></div>
                    `
                } else if (k == 'sell_fuel') {
                    if (storeCfg.type == 'gasstation') {
                        levelRequirements = levelRequirements + `
                            ${storeData.stock['fuel'].sold >= v.count && `<div class="meets"><i class="fa-solid fa-square-check"></i>` || '<div><i class="fa-solid fa-square-xmark"></i>'} ${translation.upgrade.menu_level_requirement_sell_fuel} ${storeData.stock['fuel'].sold}/<span>${v.count}</span></div>
                        `
                    }
                } else if (k == 'make_orders') {
                    levelRequirements = levelRequirements + `
                        ${storeData.data.totalOrders >= v.count && `<div class="meets"><i class="fa-solid fa-square-check"></i>` || '<div><i class="fa-solid fa-square-xmark"></i>'} ${translation.upgrade.menu_level_requirement_make_orders} ${storeData.data.totalOrders}/<span>${v.count}</span></div>
                    `
                } else if (k == 'required_money') {
                    levelRequirements = levelRequirements + `
                        ${storeData.data.balance >= v.count && `<div class="meets"><i class="fa-solid fa-square-check"></i>` || '<div><i class="fa-solid fa-square-xmark"></i>'} ${translation.upgrade.menu_level_requirement_required_money} ${number.format(storeData.data.balance)}${translation.currency}/<span>${v.count}${translation.currency}</span></div>
                    `
                }
            }
            $('div[data-type="upgrade"] div[data-type="level"] .description').html(levelRequirements)
        }

        let levelBenefits = ``;
        if (levelsBenefits[storeData.data['level']].itemsCapacity) levelBenefits = levelBenefits + `
            <div>${(translation.upgrade.menu_levelinfo_description_itemscapacity).format(levelsBenefits[storeData.data['level']].itemsCapacity, translation.quantity)}</div>
        `;
        if (levelsBenefits[storeData.data['level']].fuelCapacity) levelBenefits = levelBenefits + `
            <div>${(translation.upgrade.menu_levelinfo_description_fuelcapacity).format(levelsBenefits[storeData.data['level']].fuelCapacity, translation.liters)}</div>
        `;
        if (levelsBenefits[storeData.data['level']].moneyMarginItems) levelBenefits = levelBenefits + `
            <div>${(translation.upgrade.menu_levelinfo_description_moneymarginitems).format(levelsBenefits[storeData.data['level']].moneyMarginItems)}</div>
        `;
        if (levelsBenefits[storeData.data['level']].moneyMarginFuel) levelBenefits = levelBenefits + `
            <div>${(translation.upgrade.menu_levelinfo_description_moneymarginfuel).format(levelsBenefits[storeData.data['level']].moneyMarginFuel)}</div>
        `;
        $('.management-menu div[data-type="upgrade"] div[data-type="levelinfo"] .description').html(levelBenefits)

        let insurancesData = ''
        for (const [k, v] of Object.entries(insurances)) {
            insurancesData = insurancesData + `
                <div class="btn" data-option="insurance" onclick="buyInsurance(${Number(k)+1})"">
                    <p>${(translation.upgrade.menu_insurance_btn).format(v.days, number.format(v.price))}</p>
                </div>
            `
        }
        $('div[data-type="insurance"] .insurances-list').html(insurancesData)
        
        // CityHall Resume's - loader:
        let isResumesAllowed = item.isResumesAllowed;
        if (isResumesAllowed != undefined) {
            if (item.isResumesAllowed) {
                $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').addClass('active')
            } else {
                $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').removeClass('active')
            }
            if (item.resumes) {
                let resumesList = ``;
                let { CityHall_ResumesElement } = window.mySharedFunction();
                for (const [_, data] of Object.entries(item.resumes)) {
                    let element = CityHall_ResumesElement;
                    resumesList += element.format(data.sender_name, formatDate(data.date), data.sender, 'VIEW');
                }
                $('div[data-type="resumes"] .side-boxes > div[data-type="list"] > .resumes-list > table > tbody').html(resumesList);
            }
            $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').html(isResumesAllowed ? translation.resumes.manage_description_active : translation.resumes.manage_description_not_active);
        }

        // CityHall Taxes - loader:
        let isTaxesAllowed = item.isTaxesAllowed;
        if (isTaxesAllowed != undefined) {
            if (item.taxes) {
                let { LoadTaxesMenu } = window.mySharedFunction();
                $('div[data-type="taxes"] .side-boxes > div[data-type="list"] > .taxes-list').html(LoadTaxesMenu(item.taxes, 'vms_stores'));
            }
        }

        if (cityhallGrades) {
            $('.management-menu .menu .side-bar div[data-href="resumes"]').hide();
            if (cityhallGrades['resumes']) {
                $('.management-menu .menu .side-bar div[data-href="resumes"]').show();
            }

            $('.management-menu .menu .side-bar div[data-href="taxes"]').hide();
            if (cityhallGrades['taxes']) {
                $('.management-menu .menu .side-bar div[data-href="taxes"]').show();
            }
        }

        currentMenu = 'management';
        updateManagement('main', `.management-menu .side-bar div[data-href="main"]`);
        $('.management-menu').fadeIn(120);

        let announcementsChat = document.getElementById("announcements-chat")
        announcementsChat.scrollTop = announcementsChat.scrollHeight;
    } else if (item.action == "closeManagementMenu") {
        $('.management-menu, .management-menu > .menu > .main > div').fadeOut(120);
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        $('input[data-input="withdraw"]').val('').hide();
        $('input[data-input="deposit"]').val('').hide();
        $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal').removeClass('isVisible');
        $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');
    } else if (item.action == "updateManagementMenu") {
        if (currentMenu) {
            if (item.storeData) storeData = item.storeData;

            // CityHall Resume's - loader:
            let isResumesAllowed = item.isResumesAllowed;
            if (isResumesAllowed != undefined) {
                if (item.isResumesAllowed) {
                    $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').addClass('active')
                } else {
                    $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').removeClass('active')
                }
                if (item.resumes) {
                    let resumesList = ``
                    let { CityHall_ResumesElement } = window.mySharedFunction();
                    for (const [_, data] of Object.entries(item.resumes)) {
                        let element = CityHall_ResumesElement;
                        resumesList += element.format(data.sender_name, formatDate(data.date), data.sender, 'VIEW')
                    }
                    $('div[data-type="resumes"] .side-boxes > div[data-type="list"] > .resumes-list > table > tbody').html(resumesList);
                }
                $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').html(isResumesAllowed ? translation.resumes.manage_description_active : translation.resumes.manage_description_not_active);
            }

            // CityHall Taxes - loader:
            let isTaxesAllowed = item.isTaxesAllowed;
            if (isTaxesAllowed != undefined) {
                if (item.taxes) {
                    let { LoadTaxesMenu } = window.mySharedFunction();
                    $('div[data-type="taxes"] .side-boxes > div[data-type="list"] > .taxes-list').html(LoadTaxesMenu(item.taxes, 'vms_stores'));
                }
            }

            if (currentMenu == "main") {
                let announcementsData = ''
                for (const [k, v] of Object.entries(storeData.announcements)) {
                    if (v) {
                        announcementsData = announcementsData + `
                            <div ${v.type && `class="${v.type}"` || ''}>
                                <div class="user ${v.type && `${v.type}` || ''}">
                                    <div class="avatar"><i class="${!v.type && "fa-solid fa-user" || v.type == "alarm" && "fa-solid fa-bell" || v.type == "insurance" && "fa-solid fa-shield-halved"}"></i></div>
                                    <div class="name">${v.name}</div>
                                </div>
                                <div class="message">${v.message}</div>
                            </div>
                        `
                    }
                }
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .announcements-messages').html(announcementsData)
                let announcementsChat = document.getElementById("announcements-chat")
                announcementsChat.scrollTop = announcementsChat.scrollHeight;
            } else if (currentMenu == "upgrade") {
                const currentTimestamp = Math.floor(Date.now() / 1000);
                let daysDifference = 0
                if (storeData.data.insurance) {
                    const timeDifference = storeData.data.insurance - currentTimestamp;
                    daysDifference = Math.floor(timeDifference / (60 * 60 * 24));
                }
                $('.management-menu div[data-type="upgrade"] div[data-type="insurance"] .info').text(storeData.data.insurance ? (translation.upgrade.menu_insurance_info_days).format(daysDifference) : translation.upgrade.menu_insurance_info_none)
                $('.management-menu div[data-type="upgrade"] div[data-type="level"] .title').text((translation.upgrade.menu_level_title).format(storeData.data['level']));
                $('div[data-type="upgrade"] div[data-type="level"] .description').empty();
                if (levelsBenefits[storeData.data['level']].levelup) {
                    let levelRequirements = `<span>${translation.upgrade.menu_level_description}</span>`;
                    for (const [k, v] of Object.entries(levelsBenefits[storeData.data['level']].levelup)) {
                        if (k == 'sell_products') {
                            levelRequirements = levelRequirements + `
                                ${storeData.data.totalSales >= v.count && `<div class="meets"><i class="fa-solid fa-square-check"></i>` || '<div><i class="fa-solid fa-square-xmark"></i>'} ${translation.upgrade.menu_level_requirement_sell_products} ${storeData.data.totalSales}/<span>${v.count}</span></div>
                            `
                        } else if (k == 'sell_fuel') {
                            if (storeCfg.type == 'gasstation') {
                                levelRequirements = levelRequirements + `
                                    ${storeData.stock['fuel'].sold >= v.count && `<div class="meets"><i class="fa-solid fa-square-check"></i>` || '<div><i class="fa-solid fa-square-xmark"></i>'} ${translation.upgrade.menu_level_requirement_sell_fuel} ${storeData.stock['fuel'].sold}/<span>${v.count}</span></div>
                                `
                            }
                        } else if (k == 'make_orders') {
                            levelRequirements = levelRequirements + `
                                ${storeData.data.totalOrders >= v.count && `<div class="meets"><i class="fa-solid fa-square-check"></i>` || '<div><i class="fa-solid fa-square-xmark"></i>'} ${translation.upgrade.menu_level_requirement_make_orders} ${storeData.data.totalOrders}/<span>${v.count}</span></div>
                            `
                        } else if (k == 'required_money') {
                            levelRequirements = levelRequirements + `
                                ${storeData.data.balance >= v.count && `<div class="meets"><i class="fa-solid fa-square-check"></i>` || '<div><i class="fa-solid fa-square-xmark"></i>'} ${translation.upgrade.menu_level_requirement_required_money} ${number.format(storeData.data.balance)}${translation.currency}/<span>${v.count}${translation.currency}</span></div>
                            `
                        }
                    }
                    $('div[data-type="upgrade"] div[data-type="level"] .description').html(levelRequirements)
                }

                let levelBenefits = ``;
                if (levelsBenefits[storeData.data['level']].itemsCapacity) levelBenefits = levelBenefits + `
                    <div>${(translation.upgrade.menu_levelinfo_description_itemscapacity).format(levelsBenefits[storeData.data['level']].itemsCapacity, translation.quantity)}</div>
                `;
                if (levelsBenefits[storeData.data['level']].fuelCapacity) levelBenefits = levelBenefits + `
                    <div>${(translation.upgrade.menu_levelinfo_description_fuelcapacity).format(levelsBenefits[storeData.data['level']].fuelCapacity, translation.liters)}</div>
                `;
                if (levelsBenefits[storeData.data['level']].moneyMarginItems) levelBenefits = levelBenefits + `
                    <div>${(translation.upgrade.menu_levelinfo_description_moneymarginitems).format(levelsBenefits[storeData.data['level']].moneyMarginItems)}</div>
                `;
                if (levelsBenefits[storeData.data['level']].moneyMarginFuel) levelBenefits = levelBenefits + `
                    <div>${(translation.upgrade.menu_levelinfo_description_moneymarginfuel).format(levelsBenefits[storeData.data['level']].moneyMarginFuel)}</div>
                `;
                $('.management-menu div[data-type="upgrade"] div[data-type="levelinfo"] .description').html(levelBenefits);

                if (storeData.data.alarm) {
                    if (useCamera) {
                        $('.management-menu div[data-type="upgrade"] div[data-type="alarm"] .buttons').html(`
                            <div class="btn" onclick="checkCameras()">
                                <p>${(translation.upgrade.menu_alarm_check_cameras)}</p>
                            </div>
                        `)
                    }
                } else {
                    $('.management-menu div[data-type="upgrade"] div[data-type="alarm"] .buttons').html(`
                        <div class="btn" onclick="buyAlarm()">
                            <p>${(translation.upgrade.menu_alarm_btn).format(number.format(alarmPrice))}</p>
                        </div>
                    `)
                }
            } else if (currentMenu == "stock") {
                let stockData = ''
                /*if (storeData.stock.fuel) {
                    stockData = stockData + `
                        <div class="product ${storeData.stock.fuel.count <= 0 && `lack-of-stock` || ''} ${abilityChangeProductsPrices && (isBoss || isManager) ? 'extended-stock' : ''}">
                            <div class="info">
                                <div class="label">${productsLabels['fuel']}</div>
                            </div>
                            <div class="icon">
                                <img src="products-icons/fuel.png"draggable="false">
                            </div>
                            <div class="information">
                                <div class="stock-data">${translation.stock.stock} <span>${storeData.stock.fuel.count}${translation.liters}</span></div>
                                ${abilityChangeProductsPrices && (isBoss || isManager) ? `
                                    <hr>
                                    <div class="custom-price">
                                        <div>
                                            <span>${translation.stock.set_custom_price}</span>
                                            <span>${storeData.stock.fuel.price ? storeData.stock.fuel.price + translation.currency : translation.stock.default_price}</span>
                                        </div>
                                        <input type="number" data-item="fuel" onkeyup="checkEnter(this, event)">
                                    </div>
                                ` : ''}
                            </div>
                        </div>
                    `
                }*/
                for (const [k, v] of Object.entries(storeData.stock.products)) {
                    if (k) {
                        stockData = stockData + `
                            <div class="product ${v.count <= 0 && `lack-of-stock` || ''} ${abilityChangeProductsPrices && (isBoss || isManager) ? 'extended-stock' : ''}">
                                <div class="info">
                                    <div class="label">${productsLabels[k]}</div>
                                </div>
                                <div class="icon">
                                    ${config.iconsCustomPath && `
                                        <img src="${config.iconsCustomPath}${k}.png" draggable="false">
                                    ` || `
                                        <img src="products-icons/${k}.png" draggable="false">
                                    `}
                                </div>
                                <div class="information">
                                    <div class="stock-data">${translation.stock.stock} <span>${v.count}${translation.quantity}</span></div>
                                    ${abilityChangeProductsPrices && (isBoss || isManager) ? `
                                        <hr>
                                        <div class="custom-price">
                                            <div>
                                                <span>${translation.stock.set_custom_price}</span>
                                                <span>${v.price ? v.price + translation.currency : translation.stock.default_price}</span>
                                            </div>
                                            <input type="number" data-item="${k}" onkeyup="checkEnter(this, event)">
                                        </div>
                                    ` : ''}
                                </div>
                            </div>
                        `
                    }
                }
                $('.management-menu div[data-type="stock"] > div').html(stockData)
                
            } else if (currentMenu == "order") {
                let ordersData = ''
                for (const [k, v] of Object.entries(storeData.orders)) {
                    let products = ''
                    let price = 0
                    if (v.product) {
                        if (wholesales[v.wholesale].fuel) {
                            products = productsLabels[v.product]
                            price = (wholesales[v.wholesale].fuel?.orderPrice && wholesales[v.wholesale].fuel?.orderPrice * v.count || 0.0)
                        } else {
                            products = productsLabels[v.product] + ' ' + v.count + translation.quantity
                            price +=  wholesales[v.wholesale].products && wholesales[v.wholesale].products[v.product]?.orderPrice * v.count || 0.0
                        }
                    }
                    if (v.product2) {
                        if (products != '') products = products + ', ';
                        products = products + productsLabels[v.product2] + ' ' + v.count2 + translation.quantity
                        price +=  wholesales[v.wholesale].products && wholesales[v.wholesale].products[v.product2]?.orderPrice * v.count2 || 0.0
                    }
                    if (v.product3) {
                        if (products != '') products = products + ', ';
                        products = products + productsLabels[v.product3] + ' ' + v.count3 + translation.quantity
                        price +=  wholesales[v.wholesale].products && wholesales[v.wholesale].products[v.product3]?.orderPrice * v.count3 || 0.0
                    }
                    
                    
                    ordersData = ordersData + `
                        <tr>
                            <td class="table-first">${translation.order.table_wholesale} ${v.wholesale}</td>
                            <td>${products}</td>
                            <td>${price}${translation.currency}</td>
                            <td class="table-last">
                                ${(storeData.ordersAccepted && storeData.ordersAccepted[k]) ? `<div class="accepted-order">${translation.order.table_option_accepted}</div>` : `<div data-option="accept-order" onclick="acceptOrder('${k}')">${translation.order.table_option_accept}</div>`}
                            </td>
                        </tr>
                    `
                }
                $('.management-menu div[data-type="order"] tbody').html(ordersData)
            } else if (currentMenu == "boss-management") {
                if (storeData.data.alarm) {
                    if (useCamera) {
                        $('.management-menu div[data-type="upgrade"] div[data-type="alarm"] .buttons').html(`
                            <div class="btn" onclick="checkCameras()">
                                <p>${(translation.upgrade.menu_alarm_check_cameras)}</p>
                            </div>
                        `)
                    }
                } else {
                    $('.management-menu div[data-type="upgrade"] div[data-type="alarm"] .buttons').html(`
                        <div class="btn" onclick="buyAlarm()">
                            <p>${(translation.upgrade.menu_alarm_btn).format(number.format(alarmPrice))}</p>
                        </div>
                    `)
                }

                let announcementsData = ''
                for (const [k, v] of Object.entries(storeData.announcements)) {
                    if (v) {
                        announcementsData = announcementsData + `
                            <div ${v.type && `class="${v.type}"` || ''}>
                                <div class="user ${v.type && `${v.type}` || ''}">
                                    <div class="avatar"><i class="${!v.type && "fa-solid fa-user" || v.type == "alarm" && "fa-solid fa-bell" || v.type == "insurance" && "fa-solid fa-shield-halved"}"></i></div>
                                    <div class="name">${v.name}</div>
                                </div>
                                <div class="message">${v.message}</div>
                            </div>
                        `
                    }
                }
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .announcements-messages').html(announcementsData)
                let announcementsChat = document.getElementById("announcements-chat")
                announcementsChat.scrollTop = announcementsChat.scrollHeight;
            } else if (currentMenu == "employees" && item.players) {
                let players = item.players
                let hireData = ''
                $('.management-menu .main div[data-type="employees"] .box-right .data').html(`<div class="hire-list">no players around</div>`);
                for (const [k, v] of Object.entries(players)) {
                    hireData += `
                        <div class="hire-player" data-playerid="${v}">
                            <div>${(translation.employees.citizen).format(v)}</div>
                            <div class="hire_btn" onclick="hireEmployee(${v})">${translation.employees.menu_option_hire_btn}</div>
                        </div>
                    `;
                };
                $('.management-menu .main div[data-type="employees"] .box-right .data .hire-list').html(hireData);
            } else if (currentMenu == "employees") {
                if (item.employees) {
                    employees = item.employees
                    let employeesData = ''
                    for (const [k, v] of Object.entries(employees)) {
                        if (storeData.employees[v.identifier || v.empSource]) {
                            employeesData = employeesData + `
                                <tr>
                                    <td class="table-first">${v.name}</td>
                                    <td>${storeData.employees[v.identifier || v.empSource].orders}</td>
                                    <td>${v.job ? v.job.grade_label : v.grade.name}</td>
                                    <td class="table-last"><div onclick="manageEmployee('${v.name}', '${v.identifier || v.empSource}')">Manage</div></td>
                                </tr>
                            `
                        }
                    }
                    $('.management-menu div[data-type="employees"] tbody').html(employeesData)
                }
            } else if (currentMenu == "resell" && item.players) {
                let players = item.players
                let resellData = `
                    <select id="select-buyer" name="select-buyer" style="width: 8em;">
                        <option value="">${translation.order.select_option}</option>
                `
                for (const [k, v] of Object.entries(players)) {
                    resellData += `
                        <option value="${v}">${(translation.employees.citizen).format(v)}</option>
                    `;
                };
                resellData += `</select>`
                $(".resell .card #buyer").html((translation.resell_card.buyer).format(`
                    ${resellData}
                `, translation.currency, `
                    <input id="resell-price-input" type="number" style="width: 10em">
                `));
            }
            if (item.storeData) {
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] .title').html(`${translation.currency} ${number.format(storeData.data.balance)}`)
            }
        }
    } else if (item.action == "openPurchaseMenu") {
        currentMenu = 'purchase';
        $('.buy-business').show(120);
        $('.buy-business .info-business > .brand').html(`${translation.buy_business.brand} <span>${item.brand}</span>`);
        $('.buy-business .info-business > .address').html(`${translation.buy_business.address} <span>${item.address}</span>`);
        $('.buy-business .info-business > .price').html(`${translation.buy_business.price} <span>${translation.currency}${number.format(item.price)}</span>`);
        $('.buy-business .purchase-business > span').text(`${translation.buy_business.buy_btn} ${translation.currency}${number.format(item.price)}`);

    } else if (item.action == "closePurchaseMenu") {
        $('.buy-business').hide(120)
        
    } else if (item.action == "openReceipt") {
        console.log(item.items);
        currentMenu = 'receipt';
        $('.receipt > .receipt-texts .list').empty();
        $('.receipt').show();
        $('.receipt > .receipt-texts > .header-label').text(`${item.storeName} - ${translation.receipt.header}`);
        $('.receipt > .receipt-texts .total > div:nth-child(2)').html(`<span>${number.format(item.totalPrice)}${translation.currency}</span>`);
        for (const [k, v] of Object.entries(item.items)) {
            $('.receipt > .receipt-texts .list').append(`
                <div class="product">
                    <div>${v.label}</div>
                    <div><span>${number.format(v.price)}${translation.currency}</span></div>
                </div>
            `);
        }

        $('.receipt').fadeIn();
    } else if (item.action == "closeReceipt") {
        $('.receipt').hide();
    } else if (item.action == "openIntimidation") {
        $('.intimidation-bar').fadeIn(150);
    } else if (item.action == "updateIntimidation") {
        $('.intimidation-bar > .bar > div').css('width', `${item.val}%`);
    } else if (item.action == "closeIntimidation") {
        $('.intimidation-bar').fadeOut(150);
    } else if (item.action == "openResell") {
        currentMenu = "resell"
        let resellData = item.resellData;
        playerName = item.buyerName;
        $(".resell").show();
        $(".management-menu").hide();

        $(".resell #give_invoice").css({
            "z-index": -500,
            "opacity": 0.0
        });

        $(".resell #make_signature_seller").hide();
        $(".resell #make_signature_buyer").show();
        $(".resell #signature_seller").text(resellData.sellerName)
        $(".resell #signature_buyer").text("");
        
        $(".resell .card #title").text((translation.resell_card.title).format(resellData.brand));
        $(".resell .card #date").text((translation.resell_card.date).format(resellData.date));
        
        $(".resell .card #seller").html((translation.resell_card.seller).format(resellData.sellerName));
        $(".resell .card #buyer").html((translation.resell_card.buyer).format(playerName, translation.currency, resellData.price));

        $(".resell .card ol li#first").html((translation.resell_card.contract_first_point).format(resellData.brand, resellData.address));
        $(".resell .card ol li#second").html((translation.resell_card.contract_second_point).format(resellData.brand));
        $(".resell .card ol li#third").html((translation.resell_card.contract_third_point).format(resellData.level));

        $(".resell .card .signatures .seller .signature-text").text(translation.resell_card.seller_signature);
        $(".resell .card .signatures .buyer .signature-text").text(translation.resell_card.buyer_signature);
        
    }
});

function checkEnter(val, evt) {
    if (evt.keyCode === 13) {
        let itemName = $(val).data('item');
        let price = $(val).val();
        if (itemName && price >= 0) {
            $.post('https://vms_stores/changeItemPrice', JSON.stringify({
                item: itemName,
                price: price
            }));
        }
    }
}


$('.purchase-business[data-type="purchase"]').click(function() {
    $.post('https://vms_stores/purchase');
    isMenuOpened = false;
})

$(".close").click(function() {
    $.post('https://vms_stores/close', JSON.stringify({menu: currentMenu}));
    isMenuOpened = false;
    if (currentMenu == "resell") {
        $(".resell").fadeOut(150);
    }
})

addToCart = function(name, shelf) {
    let count = $(`input[data-name="${name}"]`).val();
    if (Number(count) >= 1) {
        $.post('https://vms_stores/addToCart', JSON.stringify({
            shelf: shelf,
            name: name,
            count: count
        }));
    }
}

$(document).on('click', '.management-menu .side-bar .button', function(e) {
    let newMenu = $(this).data('href')
    updateManagement(newMenu, this)
})

$(".management-menu .box .btn").click(function() {
    let option = $(this).data('option')
    if (option == 'send-announce') {
        let text = $('textarea[data-type="announcement"]').val();
        message = text.trim();
        if (message !== "") {
            $.post('https://vms_stores/sendAnnouncement', JSON.stringify({text: text}));
            $('textarea[data-type="announcement"]').val("")
        }

    } else if (option == "withdraw") {
        $('.box[data-type="balance"] .close-balance').addClass('isVisible');
        $('input[data-input="withdraw"]').show();
        $('.btn[data-option="deposit"]').hide();
        $('.btn[data-option="withdraw"]').hide();
    } else if (option == "deposit") {
        $('.box[data-type="balance"] .close-balance').addClass('isVisible');
        $('input[data-input="deposit"]').show();
        $('.btn[data-option="deposit"]').hide();
        $('.btn[data-option="withdraw"]').hide();
    } else if (option == "money-escort") {
        let money = $('input[data-type="moneycount"]').val();
        if (money && Number(money) && money >= 1) {
            $.post('https://vms_stores/moneyescort', JSON.stringify({money: money}));
            $('input[data-type="moneycount"]').val('');
        }
    } else if (option == "levelup") {
        $.post('https://vms_stores/levelup');
    } else if (option == "sell") {
        $.post('https://vms_stores/sell');
    } else if (option == "resell") {
        const date = new Date();
        currentDate = new Intl.DateTimeFormat(['ban', 'id']).format(date)
        currentMenu = "resell"
        $.post('https://vms_stores/get_closest_players');

        $(".resell #give_invoice").css({
            "z-index": -500,
            "opacity": 0.0
        });
        
        $(".resell").show();
        $(".management-menu").hide();
        
        $(".resell .card #title").text((translation.resell_card.title).format(storeCfg.brand));
        $(".resell .card #date").text((translation.resell_card.date).format(currentDate));
        
        $(".resell .card #seller").html((translation.resell_card.seller).format(playerName));

        $(".resell .card ol li#first").html((translation.resell_card.contract_first_point).format(storeCfg.brand, storeCfg.address));
        $(".resell .card ol li#second").html((translation.resell_card.contract_second_point).format(storeCfg.brand));
        $(".resell .card ol li#third").html((translation.resell_card.contract_third_point).format(storeData.data.level));

        $(".resell .card .signatures .seller #give_invoice").text(translation.resell_card.give_contract_btn);
        $(".resell .card .signatures .seller .signature-text").text(translation.resell_card.seller_signature);
        $(".resell .card .signatures .buyer .signature-text").text(translation.resell_card.buyer_signature);

        $(".resell #signature_seller").text("")
        $(".resell #signature_buyer").text("")
        
        $(".resell #make_signature_seller").show();
        $(".resell #make_signature_buyer").hide();
        

        
    } else if (option == "make-order") {
        let wholesale = $("#select-wholesale").val();
        let product = $("#select-product").val();
        let count = $(".count-bar input[type='radio']:checked").val();
        let product2 = null;
        let count2 = null;
        let product3 = null;
        let count3 = null;
        if (ordersLimit >= 2) {
            product2 = $("#select-product2").val();
            count2 = $(".count-bar2 input[type='radio']:checked").val();
        }
        if (ordersLimit >= 3) {
            product3 = $("#select-product3").val();
            count3 = $(".count-bar3 input[type='radio']:checked").val();
        }
        
        if (wholesale && ((product && count) || (product2 && count2) || (product3 && count3))) {
            $.post('https://vms_stores/makeOrder', JSON.stringify({
                wholesale: wholesale,

                product: product,
                count: count,
                
                product2: product2,
                count2: count2,
                
                product3: product3,
                count3: count3,
            }));
            document.getElementById("select-wholesale").value = "";
            var select2 = document.getElementById("select-product");
            select2.disabled = true;
            select2.value = "";
            $("#count-2").hide()

            var select3 = document.getElementById("select-product2");
            select3.disabled = true;
            select3.value = "";
            $("#count-3").hide()
            
            var select4 = document.getElementById("select-product3");
            select4.disabled = true;
            select4.value = "";
            $("#count-4").hide()
        }
    } else if (option == "get_closest_players") {
        $.post('https://vms_stores/get_closest_players');
    } else if (option == "employees") {
        updateManagementSub(option, `div[data-href="employees"]`)
        
    } else if (option == "upgrade") {
        updateManagementSub(option, `div[data-href="upgrade"]`)
        
    }
})

$(document).on('click', '#make_signature_buyer', function(e) {
    $(".resell #make_signature_buyer").hide();
    let signature = playerName
    const signatureElement = document.getElementById('signature_buyer');
    let currentLetterIndex = 0;
    function stopLetter() {
        $.post('https://vms_stores/resellDone');
        setTimeout(() => {
            $(".resell").fadeOut(550);
        }, 1000);
    }

    function addNextLetter() {
        signatureElement.textContent += signature[currentLetterIndex];
        currentLetterIndex++;
        if (currentLetterIndex < signature.length) {
            setTimeout(addNextLetter, 100);
        } else {
            stopLetter()
        }
    }
    
    addNextLetter();
})

$(document).on('click', '#make_signature_seller', function(e) {
    $(".resell #make_signature_seller").hide();
    let signature = playerName
    const signatureElement = document.getElementById('signature_seller');
    let currentLetterIndex = 0;
    function stopLetter() {
        $(".resell #give_invoice").css({
            "z-index": 500,
            "opacity": 1.0
        });
    }
    function addNextLetter() {
        signatureElement.textContent += signature[currentLetterIndex];
        currentLetterIndex++;
        if (currentLetterIndex < signature.length) {
            setTimeout(addNextLetter, 100);
        } else {
            stopLetter()
        }
    }
    addNextLetter();
})

$(document).on('click', '#give_invoice', function(e) {
    let selectedBuyer = $("#select-buyer").val();
    let resellPrice = $("#resell-price-input").val();
    if (!selectedBuyer) $(".resell #select-buyer").addClass("required");
    if (!resellPrice) $(".resell #resell-price-input").addClass("required");
    if (selectedBuyer && resellPrice) {
        $(".resell").fadeOut(150);
        $.post('https://vms_stores/resellSend', JSON.stringify({
            selectedBuyer: selectedBuyer,
            resellData: {
                sellerName: playerName,
                price: resellPrice,
                date: currentDate,
                brand: storeCfg.brand,
                address: storeCfg.address,
                level: storeData.data.level
            }
        }));
    }
})


function balanceButton() {
    if ($('input[data-input="withdraw"]').val() >= 1) {
        let money = $('input[data-input="withdraw"]').val()
        $.post('https://vms_stores/withdraw', JSON.stringify({money: money}));
        $('input[data-input="withdraw"]').val('').hide();
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal');
        $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');
        $('.box[data-type="balance"] .close-balance').removeClass('isVisible');
    } else if ($('input[data-input="deposit"]').val() >= 1) {
        let money = $('input[data-input="deposit"]').val()
        $.post('https://vms_stores/deposit', JSON.stringify({money: money}));
        $('input[data-input="deposit"]').val('').hide();
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal');
        $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');
        $('.box[data-type="balance"] .close-balance').removeClass('isVisible');
    } else {
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        $('input[data-input="withdraw"]').val('').hide();
        $('input[data-input="deposit"]').val('').hide();
        $('.box[data-type="balance"] .close-balance').removeClass('isVisible');
    }
}

function buyAlarm() {
    $.post('https://vms_stores/boughtAlarm');
}

function checkCameras() {
    $.post('https://vms_stores/checkCameras');
}

function buyInsurance(id) {
    if (id) {
        $.post('https://vms_stores/boughtInsurance', JSON.stringify({id: id}));
    }
}

function updateManagementSub(newMenu, _this) {
    if (newMenu == currentMenu) return;
    
    if (_this != selectedOption) {
        if (selectedOption) {
            $(selectedOption).removeClass("selected");
        }
        selectedOption = _this
        $(selectedOption).addClass("selected");
    }

    $(`div[data-type="${currentMenu}"]`).hide();

    currentMenu = newMenu
    $(`div[data-type="${currentMenu}"]`).show();

    // let htmlData = ''
    if (currentMenu == "upgrade") {
        // htmlData = htmlData + `
        // 
        // `
        // $(`div[data-type="${currentMenu}"] > div`).html(htmlData)
    }
    
}

function updateManagement(newMenu, _this) {
    if (newMenu == currentMenu) return;

    if (_this != selectedOption) {
        if (selectedOption) {
            $(selectedOption).removeClass("selected");
        }
        selectedOption = _this
        $(selectedOption).addClass("selected");
    }
    
    $(`div[data-type="${currentMenu}"]`).hide();
    currentMenu = newMenu
    $(`div[data-type="${currentMenu}"]`).show();
}

function acceptOrder(id) {
    $.post('https://vms_stores/acceptOrder', JSON.stringify({id: id}));
}

function hireEmployee(playerId) {
    if (playerId) {
        $.post('https://vms_stores/hire_employee', JSON.stringify({playerId: playerId}));
    }
}

function bonusEmployee(identifier) {
    let bonusMoney = $("#bonus-money").val();
    if (identifier && bonusMoney && bonusMoney >= 1) {
        $.post('https://vms_stores/bonus_employee', JSON.stringify({identifier: identifier, bonusMoney: bonusMoney}));
        $("#bonus-money").val('');
    }
}

function changeGradeEmployee(identifier, grade) {
    if (identifier && grade) {
        $.post('https://vms_stores/change_grade_employee', JSON.stringify({identifier: identifier, grade: grade}));
    }
}

function fireEmployee(identifier) {
    if (identifier) {
        $.post('https://vms_stores/fire_employee', JSON.stringify({identifier: identifier}));
        $('.management-menu .main div[data-type="employees"] .box-right .data').empty();
    }
}

function manageEmployee(name, identifier) {
    $('.management-menu .main div[data-type="employees"] .box-right .data').html(`
        <div class="employee-manage">
            <div class="player">
                <div class="player-name">${name}</div>
                <div class="bonus-bar">
                    <input type="number" id="bonus-money">
                    <div class="bonus" onclick="bonusEmployee('${identifier}')">${translation.employees.menu_option_bonus_btn}</div>
                </div>
                <div>
                    <div class="changegrade" onclick="changeGradeEmployee('${identifier}', 'employee')">${translation.employees.menu_option_employee_btn}</div>
                </div>
                <div>
                    <div class="changegrade" onclick="changeGradeEmployee('${identifier}', 'manager')">${translation.employees.menu_option_manager_btn}</div>
                </div>
                <div>
                    <div class="fire" onclick="fireEmployee('${identifier}')">${translation.employees.menu_option_fire_btn}</div>
                </div>
                
            </div>
        </div>
    `);
}

$(document).on('click', '.receipt .buttons .pay_cash', function(e) {
    $.post('https://vms_stores/paidReceipt', JSON.stringify({type: "cash"}));
})

$(document).on('click', '.receipt .buttons .pay_bank', function(e) {
    $.post('https://vms_stores/paidReceipt', JSON.stringify({type: "bank"}));
})

$(document).on('click', '.receipt .buttons .cancel', function(e) {
    $.post('https://vms_stores/closedReceipt', JSON.stringify({menu: currentMenu}));
    $('.receipt').hide();
})

$(document).on('keydown', 'body', function(e) {
    if (e.which == 27) {
        if (currentMenu == 'receipt') return;
        
        $.post('https://vms_stores/close', JSON.stringify({menu: currentMenu}));

        if (currentMenu == 'products') {
            $('.select-products').hide(120);
        } else if (currentMenu == 'purchase') {
            
        } else if (currentMenu == 'resell') {
            $('.resell').fadeOut(150);
            
        }
        isMenuOpened = false;
    }
    if (e.which == 69) {
        if (currentMenu != 'products') return;
        $('.select-products').hide(120);
        $.post('https://vms_stores/close', JSON.stringify({menu: currentMenu}));
        isMenuOpened = false;
    }
})

function removeFromBasket(itemName) {
    $.post('https://vms_stores/removeFromBasket', JSON.stringify({itemName: itemName}));
}

function onInputBalance(type) {
    let value = $(`input[data-input="${type}"]`).val();
    if (type == 'withdraw') {
        if (value >= 1) {
            $('.box[data-type="balance"] .close-balance').addClass('isAnyVal');
            $('.box[data-type="balance"] .close-balance > i').removeClass('fa-close').addClass('fa-check');
            
        } else {
            $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal');
            $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');

        }
    } else if (type == 'deposit') {
        if (value >= 1) {
            $('.box[data-type="balance"] .close-balance').addClass('isAnyVal');
            $('.box[data-type="balance"] .close-balance > i').removeClass('fa-close').addClass('fa-check');
            
        } else {
            $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal');
            $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');

        }
    }
}

function checkWholesale() {
    var select1 = document.getElementById("select-wholesale");
    var select2 = document.getElementById("select-product");
    var select3 = document.getElementById("select-product2");
    var select4 = document.getElementById("select-product3");

    $("#count-2").hide()
    $("#count-3").hide()
    $("#count-4").hide()
    
    select2.disabled = true;
    select2.value = "";
    
    select3.disabled = true;
    select3.value = "";

    select4.disabled = true;
    select4.value = "";

    if (select1.value != "") {
        let htmlData = `<option value="">${translation.order.select_option}</option>`
        if (select1.value != "H") {
            for (const [key, value] of Object.entries(wholesales[select1.value].products)) {
                if (storeCfg.productsToOrder[key]) {
                    htmlData = htmlData + `
                        <option value="${key}">${productsLabels[key]}</option>
                    `
                }
            }
        } else {
            if (storeCfg.productsToOrder['fuel']) {
                htmlData = htmlData + `
                    <option value="fuel">${productsLabels['fuel']}</option>
                `
            }
        }

        $("#select-product").html(htmlData)
        select2.disabled = false;
        if (ordersLimit >= 2 && select1.value != "H") {
            $("#select-product2").html(htmlData)
            select3.disabled = false;
        }
        if (ordersLimit >= 3 && select1.value != "H") {
            $("#select-product3").html(htmlData)
            select4.disabled = false;
        }
    }
}

function checkCount() {
    var select1 = document.getElementById("select-wholesale");
    let count2 = document.getElementById("select-product");
    let countbar = $("#count-2")
    let ordersQuantities = ''
    let storeLevel = storeData.data['level']

    let wholesaleData = wholesales[select1.value]
    let productData = wholesaleData.products[count2.value]
    let orderLimits = wholesaleData.orderLimitsDefault

    if ( productData.orderLimits != undefined && productData.orderLimits[storeLevel] != undefined ) {
        orderLimits = productData.orderLimits[storeLevel]
    }

    for (const [k, v] of (orderLimits).entries()) {
        ordersQuantities = ordersQuantities + `
            <div>
                <input type="radio" name="opcja" value="${v}">
                <div>${v}</div>
            </div>
        `
    }
    
    if (count2.value != "") {
        countbar.html(ordersQuantities)
        countbar.css('display', 'flex')
    } else {
        countbar.hide()
    }
}

function checkCount2() {
    var select1 = document.getElementById("select-wholesale");
    let count3 = document.getElementById("select-product2");
    let countbar2 = $("#count-3")

    let ordersQuantities = ''
    let storeLevel = storeData.data['level']

    let wholesaleData = wholesales[select1.value]
    let productData = wholesaleData.products[count3.value]
    let orderLimits = wholesaleData.orderLimitsDefault

    if ( productData.orderLimits != undefined && productData.orderLimits[storeLevel] != undefined ) {
        orderLimits = productData.orderLimits[storeLevel]
    }

    for (const [k, v] of (orderLimits).entries()) {
        ordersQuantities = ordersQuantities + `
            <div>
                <input type="radio" name="opcja" value="${v}">
                <div>${v}</div>
            </div>
        `
    }
    
    if (ordersLimit >= 2 && !wholesales[select1.value].fuel && count3.value != "") {
        countbar2.html(ordersQuantities)
        countbar2.css('display', 'flex')
    } else {
        countbar2.hide()
    }
}

function checkCount3() {
    var select1 = document.getElementById("select-wholesale");
    let count4 = document.getElementById("select-product3");
    
    let countbar3 = $("#count-4")

    let ordersQuantities = ''
    let storeLevel = storeData.data['level']

    let wholesaleData = wholesales[select1.value]
    let productData = wholesaleData.products[count4.value]
    let orderLimits = wholesaleData.orderLimitsDefault

    if ( productData.orderLimits != undefined && productData.orderLimits[storeLevel] != undefined ) {
        orderLimits = productData.orderLimits[storeLevel]
    }

    for (const [k, v] of (orderLimits).entries()) {
        ordersQuantities = ordersQuantities + `
            <div>
                <input type="radio" name="opcja" value="${v}">
                <div>${v}</div>
            </div>
        `
    }
    
    if (ordersLimit >= 3 && !wholesales[select1.value].fuel && count4.value != "") {
        countbar3.html(ordersQuantities)
        countbar3.css('display', 'flex')
    } else {
        countbar3.hide()
    }
}

function sortTable(n) {
    var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
    table = currentMenu == 'order' ? document.getElementById("orders-table") : document.getElementById("employees-table");
    switching = true;
    dir = "asc"; 

    var icons = document.getElementsByClassName("sort-icon");
    for (var i = 0; i < icons.length; i++) {
        icons[i].innerHTML = "";
    }

    var icon = document.getElementById("icon" + n);
    if (dir == "asc") {
        icon.innerHTML = "▲";
    } else {
        icon.innerHTML = "▼";
    }

    while (switching) {
        switching = false;
        rows = table.rows;
        for (i = 1; i < (rows.length - 1); i++) {
            shouldSwitch = false;
            x = rows[i].getElementsByTagName("TD")[n];
            y = rows[i + 1].getElementsByTagName("TD")[n];
            if (dir == "asc") {
                if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                    shouldSwitch= true;
                    break;
                }
            } else if (dir == "desc") {
                if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                    shouldSwitch = true;
                    break;
                }
            }
        }
        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
            switchcount ++;      
        } else {
            if (switchcount == 0 && dir == "asc") {
                dir = "desc";
                switching = true;
                icon.innerHTML = "▼";
            }
        }
    }
}