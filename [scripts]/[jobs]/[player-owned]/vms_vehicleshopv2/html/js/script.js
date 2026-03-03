let translation = {};

let lastStore = null;

let isMenuOpened = false;

let currentMenu = null;
let selectedOption = null;

let wholesales = {};

let storeCfg = {};
let storeData = {};

let employees = {};

let isEmployee = false;
let isManager = false;
let isBoss = false;
let cityhallGrades = false;

let useCityHall = false;
let useCityHallResumes = false;
let useCityHallTaxes = false;
let taxBusinessAllowMakeDelayedDeclarations = false;
let taxBusinessPercentagePerMonthForDelay = false;

let vehicleData = null;
let showPrices = null;

let playerName = "";
let currentDate = "";

// let srVehicles = [];
let vehicleSelected = null;
let speedUnit = null;

let employeesMakeOrders = null;

let canSelectNewVehicle = true;
let canPurchase = true;

let useBuildInBalance = true;
let removeBalanceFromMenu = false;

let customInfos = [];

var number = Intl.NumberFormat('en-US', {minimumFractionDigits: 0});

String.prototype.format = function() {
    var formatted = this;
    for (var i = 0; i < arguments.length; i++) {
        var regexp = new RegExp('\\{'+i+'\\}', 'gi');
        formatted = formatted.replace(regexp, arguments[i]);
    }
    return formatted;
};

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

const slider = document.querySelector(".showroom > .vehicles-list");
window.addEventListener("load", function() {
    $.post(`https://${GetParentResourceName()}/loaded`)

    let isDown = false;
    let startX;
    let scrollLeft;
    
    slider.addEventListener('mousedown', (e) => {
        isDown = true;
        slider.classList.add('active');
        startX = e.pageX - slider.offsetLeft;
        scrollLeft = slider.scrollLeft;
        cancelMomentumTracking();
    });

    slider.addEventListener('mouseleave', () => {
        isDown = false;
        slider.classList.remove('active');
    });

    slider.addEventListener('mouseup', () => {
        isDown = false;
        slider.classList.remove('active');
        beginMomentumTracking();
    });

    slider.addEventListener('mousemove', (e) => {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - slider.offsetLeft;
        const walk = (x - startX);
        var prevScrollLeft = slider.scrollLeft;
        slider.scrollLeft = scrollLeft - walk;
        velX = slider.scrollLeft - prevScrollLeft;
    });

    var velX = 0;
    var momentumID;

    slider.addEventListener('wheel', (e) => {
        cancelMomentumTracking();
    });

    function beginMomentumTracking() {
        cancelMomentumTracking();
        momentumID = requestAnimationFrame(momentumLoop);
    }

    function cancelMomentumTracking() {
        cancelAnimationFrame(momentumID);
    }

    function momentumLoop() {
        slider.scrollLeft += velX * 2;
        velX *= 0.95;
        if (Math.abs(velX) > 0.5) {
            momentumID = requestAnimationFrame(momentumLoop);
        }
    }

    
    slider.addEventListener("wheel", (evt) => {
        evt.preventDefault();

        window.requestAnimationFrame(() => {
            slider.scrollTo({ top: 0, left: slider.scrollLeft + (evt.deltaY * 2), behavior: "smooth" });
        });
    });
});

window.addEventListener('message', function(event){
    var item = event.data;
    if (item.action == "loaded") {
        speedUnit = item.speedUnit;
        employeesMakeOrders = item.employeesMakeOrders;
        useBuildInBalance = item.useBuildInBalance;
        removeBalanceFromMenu = item.removeBalanceFromMenu;
        
        useCityHall = item.useCityHall;
        useCityHallResumes = item.useCityHallResumes;
        useCityHallTaxes = item.useCityHallTaxes;
        useCityHallIncludedTaxes = item.useCityHallIncludedTaxes;

        taxBusinessAllowMakeDelayedDeclarations = item.taxBusinessAllowMakeDelayedDeclarations;
        taxBusinessPercentagePerMonthForDelay = item.taxBusinessPercentagePerMonthForDelay;

        customInfos = item.customInfos;

        for (const [className, data] of Object.entries(customInfos)) {
            $('.showroom > .header-left > .data').append(`
                <div class="val ${className}">
                    <img src="/html/icons/${data.icon}">
                    <span class="text">${data.name}</span>
                    <span class="value"></span>
                </div>
            `)
        }

        let lang = item.lang;
        $.ajax({
            url: '../config/translation.json',
            type: 'GET',
            dataType: 'json',
            success: function (code, statut) {
                if (!code[lang]) {
                    translation = code["EN"];
                    console.error(`^3[WARNING] ^7Selected language ^1"${lang}"^7 not found, changed to ^2"EN"^7, configure your language in translation.json.`);
                } else {
                    translation = code[lang];
                }

                // Management Translation:
                $('.management-menu .side-bar div[data-href="main"] .title').text(translation.sidebar.main_title);
                $('.management-menu .side-bar div[data-href="main"] .description').text(translation.sidebar.main_description);
                $('.management-menu .side-bar div[data-href="stock"] .title').text(translation.sidebar.stock_title);
                $('.management-menu .side-bar div[data-href="stock"] .description').text(translation.sidebar.stock_description);
                $('.management-menu .side-bar div[data-href="vehicles-on-display"] .title').text(translation.sidebar.vehicles_on_display_title);
                $('.management-menu .side-bar div[data-href="vehicles-on-display"] .description').text(translation.sidebar.vehicles_on_display_description);
                $('.management-menu .side-bar div[data-href="orders"] .title').text(translation.sidebar.orders_title);
                $('.management-menu .side-bar div[data-href="orders"] .description').text(translation.sidebar.orders_description);
                $('.management-menu .side-bar div[data-href="order"] .title').text(translation.sidebar.order_title);
                $('.management-menu .side-bar div[data-href="order"] .description').text(translation.sidebar.order_description);
                $('.management-menu .side-bar div[data-href="employees"] .title').text(translation.sidebar.employees_title);
                $('.management-menu .side-bar div[data-href="employees"] .description').text(translation.sidebar.employees_description);
                $('.management-menu .side-bar div[data-href="history-sales"] .title').text(translation.sidebar.history_sales_title);
                $('.management-menu .side-bar div[data-href="history-sales"] .description').text(translation.sidebar.history_sales_description);
                $('.management-menu .side-bar div[data-href="boss-management"] .title').text(translation.sidebar.boss_management_title);
                $('.management-menu .side-bar div[data-href="boss-management"] .description').text(translation.sidebar.boss_management_description);
                
                // Main:
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .header').text(translation.main.menu_announcements_header);
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .title').text(translation.main.menu_announcements_title);
                $('.management-menu div[data-type="main"] div[data-type="total-sales"] .header').text(translation.main.menu_total_sales_header);
                $('.management-menu div[data-type="main"] div[data-type="total-earned"] .header').text(translation.main.menu_total_earned_header);
                $('.management-menu div[data-type="main"] div[data-type="best-sellers"] .header').text(translation.main.menu_best_sellers_header);

                // Orders:
                $('.management-menu div[data-type="orders"] .orders-list #orders-table thead tr th span#vehicles').text(translation.orders.table_vehicles);
                $('.management-menu div[data-type="orders"] .orders-list #orders-table thead tr th span#option').text(translation.orders.table_option);
                
                // Order:
                $('.management-menu div[data-type="order"] .header').text(translation.order.menu_order_header);
                $('.management-menu div[data-type="order"] .title').text(translation.order.menu_order_title);
                $('.management-menu div[data-type="order"] div[data-option="make-order"] p').text(translation.order.menu_order_btn);
                $('.management-menu div[data-type="order"] .vehicles-filters > span').text(translation.filters.filters);
                $('.management-menu div[data-type="order"] .vehicles-filters .filters-list #vehicle-brand-label').text(translation.filters.filters_brand)
                $('.management-menu div[data-type="order"] .vehicles-filters .filters-list #vehicle-model-label').text(translation.filters.filters_model)
                $('.management-menu div[data-type="order"] .vehicles-filters .filters-list #min-price-label').text(translation.filters.filters_minprice)
                $('.management-menu div[data-type="order"] .vehicles-filters .filters-list #max-price-label').text(translation.filters.filters_maxprice)
                $('.management-menu div[data-type="order"] .vehicles-filters .filters-list button').text(translation.filters.menu_filters_apply);

                // Employees:
                $('.management-menu div[data-type="employees"] .header').text(translation.employees.menu_employees_header);
                $('.management-menu div[data-type="employees"] .title').text(translation.employees.menu_employees_title);
                $('.management-menu div[data-type="employees"] .btn[data-option="get_closest_players"] p').text(translation.employees.menu_employees_btn);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#employee').text(translation.employees.table_employee);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#orders').text(translation.employees.table_orders);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#grade').text(translation.employees.table_grade);
                $('.management-menu div[data-type="employees"] .employees-list #employees-table thead tr th span#option').text(translation.employees.table_option);

                // Sales History:
                $('.management-menu div[data-type="history-sales"] .history-list #history-table > thead > tr > th #date').text(translation.sales_history.table_date);
                $('.management-menu div[data-type="history-sales"] .history-list #history-table > thead > tr > th #seller').text(translation.sales_history.table_seller);
                $('.management-menu div[data-type="history-sales"] .history-list #history-table > thead > tr > th #buyer').text(translation.sales_history.table_buyer);
                $('.management-menu div[data-type="history-sales"] .history-list #history-table > thead > tr > th #vehicle').text(translation.sales_history.table_vehicle);
                $('.management-menu div[data-type="history-sales"] .history-list #history-table > thead > tr > th #price').text(translation.sales_history.table_price);
                
                // Management:
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] .header').text(translation.management.menu_balance_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] div[data-option="withdraw"] p').text(translation.management.menu_balance_btn_withdraw);
                $('.management-menu div[data-type="boss-management"] div[data-type="balance"] div[data-option="deposit"] p').text(translation.management.menu_balance_btn_deposit);
                $('.management-menu div[data-type="boss-management"] div[data-type="employees-count"] .header').text(translation.management.menu_employees_header);
                $('.management-menu div[data-type="boss-management"] div[data-option="employees"] p').text(translation.management.menu_employees_btn_manage);
                $('.management-menu div[data-type="boss-management"] div[data-type="send-announcement"] .header').text(translation.management.menu_announcement_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="send-announcement"] .title').text(translation.management.menu_announcement_title);
                $('.management-menu div[data-type="boss-management"] div[data-type="send-announcement"] .btn p').text(translation.management.menu_announcement_btn_send);
                $('.management-menu div[data-type="boss-management"] div[data-type="sell"] .header').text(translation.management.menu_sell_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="sell"] .title').text(translation.management.menu_sell_title);
                $('.management-menu div[data-type="boss-management"] div[data-type="resell"] .header').text(translation.management.menu_resell_header);
                $('.management-menu div[data-type="boss-management"] div[data-type="resell"] .title').text(translation.management.menu_resell_title);
                $('.management-menu div[data-type="boss-management"] div[data-type="resell"] .btn > p').text(translation.management.menu_resell_btn);

                // Sell Card:
                $(".resell .card #title").text(translation.resell_card.title);
                $(".resell .card #date > p").text(translation.resell_card.date);
                $(".resell .card .signatures .seller .signature-text").text(translation.resell_card.seller_signature);
                $(".resell .card .signatures .buyer .signature-text").text(translation.resell_card.buyer_signature);
                
                // Contract:
                $(".contract .card #title").text(translation.delivery_card.title);
                $(".contract .card #date > p").text(translation.resell_card.date);
                $(".contract .order_details").html(translation.delivery_card.order_details);
                $(".contract .details_paid_status").html(translation.delivery_card.order_details_paid_status);
                $(".contract .additional_details").html(translation.delivery_card.order_additional_details);
                $(".contract .paragraph_text").html(translation.delivery_card.paragraph);
                $(".contract .card .signatures .seller .signature-text").text(translation.resell_card.seller_signature);
                $(".contract .card .signatures .buyer .signature-text").text(translation.resell_card.buyer_signature);

                // Showroom:
                $('.showroom > .header-left > .data > .seats > span.text').text(translation.showroom.seats)
                $('.showroom > .header-left > .data > .max-speed > span.text').text(translation.showroom.max_speed)
                $('.showroom .color-selector[data-type="primary"] > p > span').text(translation.showroom.select_primary)
                $('.showroom .color-selector[data-type="secondary"] > p > span').text(translation.showroom.select_secondary)
                $('.showroom .color-selector[data-type="pearlescent"] > p > span').text(translation.showroom.select_pearlescent)
                $('.showroom .purchase-btn > span').text(translation.showroom.purchase_btn)
                $('.showroom>.help-infos .text').text(translation.showroom.help_freecam);
                $('.showroom .vehicles-filters > span').text(translation.filters.filters);
                $('.showroom .vehicles-filters .filters-list #vehicle-category').text(translation.filters.filters_category)
                $('.showroom .vehicles-filters .filters-list #vehicle-brand-label').text(translation.filters.filters_brand)
                $('.showroom .vehicles-filters .filters-list #vehicle-model-label').text(translation.filters.filters_model)
                $('.showroom .vehicles-filters .filters-list #min-price-label').text(translation.filters.filters_minprice)
                $('.showroom .vehicles-filters .filters-list #max-price-label').text(translation.filters.filters_maxprice)
                $('.showroom .vehicles-filters .filters-list button').text(translation.filters.menu_filters_apply);

                // Test Drive:
                $('.testDrive > div > span').text(translation.testdrive.remaining_time);

                
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
    } else if (item.action == "openShowroom") {
        canSelectNewVehicle = true;
        canPurchase = true;
        playerName = item.playerName;
        storeCfg = item.storeCfg;
        vehicleSelected = null;
        currentMenu = "showroom";
        var vehicles = storeCfg.vehicles;
        var vehiclesList = ``
        
        $(`.showroom .vehicles-list div`).removeClass("active");
        $(`.color-selector .colors-grid span.color`).removeClass("active");
        $('.showroom > .header-left > .informations, .showroom > .header-left > .data > .price, .showroom .vehicles-filters #min-price, .showroom .vehicles-filters #max-price, .showroom .purchase-btn, .showroom .test-drive-btn, .showroom>.header-left>.data>.val, .showroom>.header-right').hide();
        $('.showroom > .vehicles-list').empty();
        $(".showroom #vehicle-brand-input, .showroom #vehicle-model-input, .showroom #min-price-input, .showroom #max-price-input").val('');

        loadCategoryFilter(storeCfg.categories);

        if (storeCfg.showPrices) $('.showroom .vehicles-filters #min-price, .showroom .vehicles-filters #max-price').show();
        if (storeCfg.allowPurchase) $('.showroom .purchase-btn').show();
        if (storeCfg.allowTestDrive) $('.showroom .test-drive-btn').show();
        
        Object.keys(vehicles).forEach(key => {
            if (item.showOnlyAvailable && (item.showOnlyAvailable[key] && item.showOnlyAvailable[key].count >= 1) || !item.showOnlyAvailable ) {
                if (vehicles[key] == true) {
                    console.log(key)
                }
                let vehiclesData = `
                    <div data-category="${vehicles[key].category}" data-model="${vehicles[key].model}" onclick="selectVehicle('${vehicles[key].model}', '${vehicles[key].brand}', '${vehicles[key].name}', '${!useCityHallIncludedTaxes && vehicles[key].priceWithTax || vehicles[key].price}', '${vehicles[key].maxSpeed}', '${vehicles[key].seats}')">
                        ${(vehicles[key].brand && config.brandsLogos[vehicles[key].brand]) ? `<img src="/html/icons/brands/${config.brandsLogos[vehicles[key].brand]}" draggable="false">` : ``}
                        <div class="vehicle-img">
                            <img src="/html/icons/vehicles/${vehicles[key].model}.png" draggable="false">
                        </div>
                        <div class="informations">
                            <div class="model">
                                <span class="brand-name">${vehicles[key].brand}</span>
                                <span class="model-name">${vehicles[key].name}</span>
                            </div>
                            ${storeCfg.showPrices ? `
                                <div class="price">
                                    <span>${translation.currency}${!useCityHallIncludedTaxes && vehicles[key].priceWithTax && number.format(vehicles[key].priceWithTax) || number.format(vehicles[key].price)}</span>
                                </div>
                            ` : ``}
                        </div>
                    </div>
                `;
                vehiclesList += vehiclesData;
            }
        });
        
        $('.showroom .test-drive-btn > span').html((storeCfg.testDrivePrice && storeCfg.testDrivePrice >= 1) ? (translation.showroom.test_drive_btn).format(storeCfg.testDrivePrice, translation.currency) : (translation.showroom.test_drive_btn).format('', ''))
        $('.showroom > .vehicles-list').html(vehiclesList)
        $('.showroom').show()
    } else if (item.action == "closeShowroom") {
        if (!canSelectNewVehicle) return;
        $(".showroom .vehicles-filters select#vehicle-category").select2("close");
        $('.showroom').fadeOut(120);
    } else if (item.action == "testDrive") {
        if (!canSelectNewVehicle) return;
        $(".showroom .vehicles-filters select#vehicle-category").select2("close");
        if (item.start) {
            $('.showroom').fadeOut(120);
            $('.testDrive').show();
        } else {
            $(`.color-selector .colors-grid span.color`).removeClass("active");
            $('.testDrive').hide()
            if (!item.closeAll) {
                $('.showroom').show()
            }
        }
    } else if (item.action == "testDriveUpdate") {
        if (item.time) {
            $('.testDrive #remaining-time').html(`${item.time} <span>s</span>`)
        }
    } else if (item.action == "openManagementMenu") {
        playerName = item.playerName;

        isEmployee = item.isEmployee;
        isManager = item.isManager;
        isBoss = item.isBoss;
        cityhallGrades = item.cityhallGrades;

        storeCfg = item.storeCfg;
        storeData = item.storeData;
        employees = item.employees;
        
        // Main Menu - loader:
        $('.management-menu .header .store-name').html(`${storeCfg.brand} <span>${storeCfg.address}</span>`)

        if (item.isManager || item.isBoss) {
            $('.management-menu .menu .side-bar div[data-href="order"]').show();
            $('.management-menu .menu .side-bar div[data-href="employees"]').show();
            $('.management-menu .menu .side-bar div[data-href="history-sales"]').show();
            // $('.management-menu .menu .side-bar div[data-href="history-tests"]').show();
            $('.management-menu .menu .side-bar div[data-href="boss-management"]').show();
            $('.management-menu').addClass(item.isManager && 'isManager' || '').removeClass(item.isBoss && 'isManager' || '').removeClass('isEmployee');
        } else {
            $('.management-menu .menu .side-bar div[data-href="order"]').hide();
            $('.management-menu .menu .side-bar div[data-href="employees"]').hide();
            $('.management-menu .menu .side-bar div[data-href="history-sales"]').hide();
            // $('.management-menu .menu .side-bar div[data-href="history-tests"]').hide();
            $('.management-menu .menu .side-bar div[data-href="boss-management"]').hide();
        }
        if (employeesMakeOrders) $('.management-menu .menu .side-bar div[data-href="order"]').show();

        // Announcements - loader:
        let announcementsData = loadAnnoucements(storeData.announcements);
        $('.management-menu div[data-type="main"] div[data-type="announcements"] .announcements-messages').html(announcementsData);

        // Total Sales - loader:
        $('.management-menu div[data-type="main"] div[data-type="total-sales"] .title').html(`${storeData.data.totalSales}`);

        // Total Earned - loader:
        $('.management-menu div[data-type="main"] div[data-type="total-earned"] .title').html(`${translation.currency} ${number.format(storeData.data.totalEarned)}`);

        // Best Sellers - loader:
        let bestsellersData = loadBestsellers(storeData.stock);
        $('.management-menu .main div[data-type="main"] .side-boxes div[data-type="best-sellers"] .products-list').html(bestsellersData);

        // Stock - loader:
        let stockData = loadStock(storeData.stock);
        $('.management-menu div[data-type="stock"] > div').html(stockData);

        if (storeCfg.vehiclesOnDisplay && Object.keys(storeCfg.vehiclesOnDisplay).length > 0) {
            loadVehiclesOnDisplay();
        } else {
            $('.management-menu .side-bar > div[data-href="vehicles-on-display"]').hide();
        }

        // Orders - loader:
        let ordersData = loadOrders(storeData.orders, storeData.ordersAccepted);
        $('.management-menu div[data-type="orders"] tbody').html(ordersData);

        // Order - loader:
        if (lastStore != item.storeName) {
            let orderData = loadOrder(storeCfg.vehicles);
            $('.management-menu div[data-type="order"] .vehicles-list > div').html(orderData);
            lastStore = item.storeName;
        }

        // Employees - loader:
        let employeesData = loadEmployees(employees);
        $('.management-menu div[data-type="employees"] .box .data').html("");
        $('.management-menu div[data-type="employees"] tbody').html(employeesData);
        
        // Sales History - loader:
        let salesHistoryData = loadSalesHistory(storeData.history.sales);
        $('.management-menu div[data-type="history-sales"] tbody').html(salesHistoryData);

        // Balance - loader:
        if (useBuildInBalance) {
            loadBalance(storeData.data.balance);
        }

        // Employees Count - loader:
        $('.management-menu div[data-type="boss-management"] div[data-type="employees-count"] .title').html(`${item.employeesCount}`)

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
                $('div[data-type="taxes"] .side-boxes > div[data-type="list"] > .taxes-list').html(LoadTaxesMenu(item.taxes, 'vms_vehicleshopv2'));
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

        let announcementsChat = document.getElementById("announcements-chat");
        announcementsChat.scrollTop = announcementsChat.scrollHeight;
    } else if (item.action == "closeManagementMenu") {
        $('.management-menu,.management-menu>.menu>.main>div').fadeOut(120);
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        $('input[data-input="withdraw"]').val('').hide();
        $('input[data-input="deposit"]').val('').hide();
        $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal').removeClass('isVisible');
        $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');
    } else if (item.action == "updateManagementMenu") {
        if (currentMenu) {
            if (item.storeData) storeData = item.storeData;
            
            if (item.taxes != undefined) {
                let { LoadTaxesMenu } = window.mySharedFunction();
                $('div[data-type="taxes"] .side-boxes > div[data-type="list"] > .taxes-list').html(LoadTaxesMenu(item.taxes, 'vms_vehicleshopv2'));
            }

            if (item.isResumesAllowed != undefined) {
                if (item.isResumesAllowed) {
                    $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').addClass('active')
                } else {
                    $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').removeClass('active')
                }
                $('.management-menu div[data-type="resumes"] div[data-type="manage"] > .description > span').html(item.isResumesAllowed ? translation.resumes.manage_description_active : translation.resumes.manage_description_not_active);
            }
            
            if (currentMenu == "main") {
                let announcementsData = loadAnnoucements(storeData.announcements);
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .announcements-messages').html(announcementsData);
                let announcementsChat = document.getElementById("announcements-chat")
                announcementsChat.scrollTop = announcementsChat.scrollHeight;
            } else if (currentMenu == "order") {
                if (item.newOrder) {
                    let ordersData = '';
                    let totalPrice = 0;
                    for (const [k, v] of Object.entries(item.newOrder)) {
                        totalPrice += Number(v.orderprice);
                        ordersData = ordersData + `
                            <div>
                                <div class="name">${v.brand} ${v.name}</div>
                                <div class="remove" onclick="removeFromOrder('${Number(k)+1}')">
                                    <i class="fa-solid fa-xmark"></i>
                                </div>
                            </div>
                        `
                    }
                    $('.management-menu div[data-type="order"] > div > .box > .data > .list').html(ordersData);
                    $('.management-menu div[data-type="order"] > div > .box > .data > .totalprice').html(`${number.format(totalPrice)}${translation.currency}`);
                }
                if (item.orderDone) {
                    $('.management-menu div[data-type="order"] > div > .box > .data > .list').empty();
                    $('.management-menu div[data-type="order"] > div > .box > .data > .totalprice').html(``)
                }
            } else if (currentMenu == "boss-management") {
                let announcementsData = loadAnnoucements(storeData.announcements);
                $('.management-menu div[data-type="main"] div[data-type="announcements"] .announcements-messages').html(announcementsData);
                let announcementsChat = document.getElementById("announcements-chat");
                announcementsChat.scrollTop = announcementsChat.scrollHeight;
            } else if (currentMenu == "employees" && item.players) {
                let players = item.players
                let hireData = ''
                $('.management-menu .main div[data-type="employees"] .box-right .data').html(`<div class="hire-list">${translation.employees.menu_employees_no_players}</div>`);
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
                    let employeesData = loadEmployees(employees);
                    $('.management-menu div[data-type="employees"] tbody').html(employeesData)
                }
            } else if (currentMenu == "resell" && item.players) {
                let players = item.players
                let playersList = `
                    <select id="select-buyer" name="select-buyer" style="width: 8em;">
                        <option value="">${translation.resell_card.select_option}</option>
                `
                for (const [k, v] of Object.entries(players)) {
                    playersList += `
                        <option value="${v}">${(translation.employees.citizen).format(v)}</option>
                    `;
                };
                playersList += `</select>`
                
                let licensePlate = storeCfg.abilityCustomLicensePlate ? (translation.resell_card.license_plate).format(`<input id="resell-licenseplate-input" oninput="checkPlateInput(this)" placeholder="${translation.resell_card.licenseplate_placeholder}" style="width: 9.5em">`) : ''

                let colorsListPrimary = `
                    <select id="select-color-primary" name="select-color" style="width: 14em;">
                        <option value="">${translation.resell_card.select_option}</option>`
                let colorsListSecondary = `
                    <select id="select-color-secondary" name="select-color" style="width: 14em;">
                        <option value="">${translation.resell_card.select_option}</option>`
                let colorsListPearlescent = `
                    <select id="select-color-pearlescent" name="select-color" style="width: 14em;">
                        <option value="">${translation.resell_card.select_option}</option>`
                for (const [k, v] of Object.entries(config.colorsList)) {
                    colorsListPrimary += `
                        <option value="${v.id}" name="${v.label}">${v.label}</option>
                    `;
                    colorsListSecondary += `
                        <option value="${v.id}" name="${v.label}">${v.label}</option>
                    `;
                    colorsListPearlescent += `
                        <option value="${v.id}" name="${v.label}">${v.label}</option>
                    `;
                };
                colorsListPrimary += `</select>`
                colorsListSecondary += `</select>`
                colorsListPearlescent += `</select>`
                
                $(".resell .card .paragraph_text_1").html(`
                    ${(translation.resell_card.paragraph_1_text).format(playersList, vehicleData.brand, vehicleData.name, licensePlate, (translation.resell_card.color).format(colorsListPrimary, colorsListSecondary, colorsListPearlescent))}
                `);

                $(".resell .card .paragraph_text_2").html(`
                    ${(translation.resell_card.paragraph_2_text).format(`${storeCfg.brand} - ${storeCfg.address}`)}
                    ${translation.resell_card.paragraph_2_text_2}
                `);

                let paymentMethods = storeCfg.paymentMethods
                let paymentMethod = `
                    <select id="select-payment-method" name="select-payment-method" style="width: 9em;">
                        <option value="">${translation.resell_card.select_option}</option>
                `
                if (paymentMethods) {
                    (paymentMethods).forEach(element => {
                        paymentMethod += `<option value="${element}">${translation.resell_card[element]}</option>`
                    });
                }
                paymentMethod += `</select>`
                $(".resell .card .paragraph_text_3").html(`
                    ${(translation.resell_card.paragraph_3_text).format(`<input id="sell-price-input" type="number" style="width: 10em">`, translation.currency, paymentMethod)}
                    ${(translation.resell_card.paragraph_3_text_2).format(storeCfg.brand)}
                `);
            }
            if (item.societyBalance) {
                loadBalance(Number(item.societyBalance));
            };
            if (item.storeData) {
                if (useBuildInBalance) {
                    loadBalance(storeData.data.balance);
                }
                let ordersData = loadOrders(storeData.orders, storeData.ordersAccepted);
                $('.management-menu div[data-type="orders"] tbody').html(ordersData);
            }
        }
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
        
        $(".resell .card #date > div").text(`${resellData.date} - ${translation.resell_card.town}`);
        
        
        
        $(".resell .card .paragraph_text_1").html(`
            ${(translation.resell_card.paragraph_1_text).format(playerName, resellData.vehicle.brand, resellData.vehicle.name, `${resellData.licensePlate ? (translation.resell_card.license_plate).format(resellData.licensePlate) : ''}`, (translation.resell_card.color).format(resellData.colorPrimary.name, resellData.colorSecondary.name, resellData.colorPearlescent.name))}
        `);

        $(".resell .card .paragraph_text_2").html(`
            ${(translation.resell_card.paragraph_2_text).format(`${resellData.brand} - ${resellData.address}`)}
            ${translation.resell_card.paragraph_2_text_2}
        `);

        $(".resell .card .paragraph_text_3").html(`
            ${(translation.resell_card.paragraph_3_text).format(number.format(resellData.price), translation.currency, translation.resell_card[resellData.paymentMethod])}
            ${(translation.resell_card.paragraph_3_text_2).format(resellData.brand)}
        `);
        
    } else if (item.action == "openContractCard") {
        currentDate = getDate();

        currentMenu = "contract"
        playerName = item.buyerName;
        $(".contract").show();

        $(".contract #make_signature_contract").show();
        $(".contract #signature_seller").text(translation.delivery_card.seller_signature_text)
        $(".contract #signature_buyer_contract").text("");

        let totalPrice = 0
        let vehiclesList = `${translation.delivery_card.order_details_vehicles}<br>`
        for (const [k, v] of Object.entries(item.order.vehicles)) {
            totalPrice += v.orderprice
            vehiclesList += `
                <span>${v.brand} ${v.name}</span>
            `
        };

        $(".contract .card .details_date").text((translation.delivery_card.order_details_date).format(currentDate));
        $(".contract .card .details_vehicles").html(vehiclesList);
        $(".contract .card .details_price").text((translation.delivery_card.order_details_price).format(totalPrice, translation.currency));
        
        $(".contract .card .additional_details_text").text((translation.delivery_card.order_additional_details_store).format(item.storeBrand, item.storeAddress));
        
    }
});

$(".close").click(function() {
    if (!canSelectNewVehicle) return;
    if (currentMenu == "resell") {
        if (!canPurchase) return;
        $(".resell").fadeOut(150);
    }
    if (currentMenu == "contract") {
        if (!canPurchase) return;
        $(".contract").fadeOut(150);
    }
    if (currentMenu == "purchaseCard") {
        if (!canPurchase) return;
        $(".resell").fadeOut(150);
        $(".showroom").fadeIn(150);
        currentMenu = "showroom";
        return;
    }
    $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({menu: currentMenu}));
    isMenuOpened = false;
})

addToOrder = (model) => {
    $.post(`https://${GetParentResourceName()}/addToOrder`, JSON.stringify({model: model}));
}

removeFromOrder = (id) => {
    $.post(`https://${GetParentResourceName()}/removeFromOrder`, JSON.stringify({id: id}));
}

$(".showroom .purchase-btn").click(function() {
    if (!vehicleSelected) return;
    if (!canPurchase) return;
    
    currentMenu = "purchaseCard"
    $(".resell").show();
    $(".showroom").hide();

    $(".resell #give_invoice").css({
        "z-index": -500,
        "opacity": 0.0
    });

    currentDate = getDate();
    $(".resell .card #date > div").text(`${currentDate} - ${translation.resell_card.town}`);

    $(".resell #make_signature_seller").hide();
    $(".resell #make_signature_buyer").show();
    $(".resell #signature_seller").text(storeCfg.brand)
    $(".resell #signature_buyer").text("");
    
    let licensePlate = storeCfg.abilityCustomLicensePlate ? (translation.resell_card.license_plate).format(`<input id="resell-licenseplate-input" oninput="checkPlateInput(this)" placeholder="${translation.resell_card.licenseplate_placeholder}" style="width: 9.5em">`) : ''
    $(".resell .card .paragraph_text_1").html(`
        ${(translation.resell_card.paragraph_1_text).format(playerName, vehicleSelected.brand, vehicleSelected.name, licensePlate, '')}
    `);

    $(".resell .card .paragraph_text_2").html(`
        ${(translation.resell_card.paragraph_2_text).format(`${storeCfg.brand} - ${storeCfg.address}`)}
        ${translation.resell_card.paragraph_2_text_2}
    `);

    let paymentMethods = storeCfg.paymentMethods
    let paymentMethod = `
        <select id="select-payment-method" name="select-payment-method" style="width: 9em;">
            <option value="">${translation.resell_card.select_option}</option>
    `
    if (paymentMethods) {
        (paymentMethods).forEach(element => {
            paymentMethod += `<option value="${element}">${translation.resell_card[element]}</option>`
        });
    }
    paymentMethod += `</select>`
    $(".resell .card .paragraph_text_3").html(`
        ${(translation.resell_card.paragraph_3_text).format(vehicleSelected.price, translation.currency, paymentMethod)}
        ${(translation.resell_card.paragraph_3_text_2).format(storeCfg.brand)}
    `);

})
    
$(".color-selector").click(function() {
    let $selectedColorGrid = $(this).find("> div");
    
    $(".color-selector > div").not($selectedColorGrid).slideUp("slow");
    
    $(".color-selector i").removeClass("active");
    
    $(this).find("i").addClass("active");
    
    $selectedColorGrid.slideDown("slow");
});

$(document).on('click', '.management-menu .side-bar .button', function(e) {
    let newMenu = $(this).data('href')
    updateManagement(newMenu, this)
})

selectVehicle = (model, brand, name, price, maxSpeed, seats) => {
    if (!canSelectNewVehicle) return;
    canSelectNewVehicle = false;
    if (config.brandsLogos[brand]) {
        $(".showroom > .header-left > .informations img").attr("src", `/html/icons/brands/${config.brandsLogos[brand]}`).show();
    } else {
        $(".showroom > .header-left > .informations img").hide();
    }

    $(`.color-selector .colors-grid span.color`).removeClass("active");
    $(`.showroom .vehicles-list div`).removeClass("active");
    $(`.showroom .vehicles-list div[data-model="${model}"]`).addClass('active');
    
    $(".showroom > .header-left > .informations .brand-name").html(brand);
    $(".showroom > .header-left > .informations .model-name").html(name);
    if (storeCfg.showPrices) {
        if (price) {
            $(".showroom > .header-left > .data > .price").html(`${translation.currency}${number.format(price)}`);
        } else {
            $(".showroom > .header-left > .data > .price").fadeOut(250);
        }
    }
    
    $(".showroom>.header-left>.data>.seats>.value").html(seats);
    $(".showroom>.header-left>.data>.max-speed>.value").html(`${maxSpeed} ${speedUnit == "mph" ? translation.miles_unit : translation.kilometers_unit}`);

    for (const [className, data] of Object.entries(customInfos)) {
        if (storeCfg.vehicles[model][className] != undefined) {
            $(`.showroom > .header-left > .data > .${className} > .value`).text(`${(data.value).format(storeCfg.vehicles[model][className])}`)
            $(`.showroom > .header-left > .data > .${className}`).fadeIn(80);
        } else {
            $(`.showroom > .header-left > .data > .${className}`).fadeOut(80);
        }
    };

    if (!vehicleSelected) {
        $('.showroom > .header-left > .informations').fadeIn(250);
        if (storeCfg.showPrices) {
            $('.showroom > .header-left > .data > .price').fadeIn(250);
        }

        $('.showroom>.header-left>.data>.seats').fadeIn(250);
        $('.showroom>.header-left>.data>.max-speed').fadeIn(250);

        $('.showroom>.header-right').fadeIn(250);
    }
    
    vehicleSelected = {model:model, brand:brand, name:name, price:price};

    $.post(`https://${GetParentResourceName()}/selectVehicle`, JSON.stringify({
        model: model,
    }), function(canChoose) {
        canSelectNewVehicle = canChoose;
    });
}

$(".btn").click(function() {
    let option = $(this).data('option')
    if (option == 'send-announce') {
        let text = $('textarea[data-type="announcement"]').val();
        message = text.trim();
        if (message !== "") {
            $.post(`https://${GetParentResourceName()}/sendAnnouncement`, JSON.stringify({text: text}));
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
    } else if (option == "make-order") {
        $.post(`https://${GetParentResourceName()}/makeOrder`);
    } else if (option == "get_closest_players") {
        $.post(`https://${GetParentResourceName()}/getClosestPlayers`);
    } else if (option == "employees") {
        updateManagementSub(option, `div[data-href="employees"]`)
    }
})

$(document).on('click', '.management-menu div[data-type="vehicles-on-display"] > div > div > .change_btn', function(e) {
    let id = $(this).data('id')
    let vehicleModel = $(`.management-menu div[data-type="vehicles-on-display"] div[data-id="${id}"] select`).val();
    $.post(`https://${GetParentResourceName()}/setVehicleOnDisplay`, JSON.stringify({id: id, vehicleModel: vehicleModel}));
})

$(document).on('click', '#make_signature_contract', function(e) {
    $(".contract #make_signature_contract").hide();
    let signature = playerName
    const signatureElement = document.getElementById('signature_buyer_contract');
    let currentLetterIndex = 0;
    function stopLetter() {
        $.post(`https://${GetParentResourceName()}/contractDone`);
        setTimeout(() => {
            $(".contract").fadeOut(550);
            currentMenu = null;
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

$(document).on('click', '#make_signature_buyer', function(e) {
    $(".resell #make_signature_buyer").hide();
    let signature = playerName
    const signatureElement = document.getElementById('signature_buyer');
    let currentLetterIndex = 0;
    
    function stopLetter() {
        if (currentMenu == "purchaseCard") {
            let licensePlate = storeCfg.abilityCustomLicensePlate ? $("#resell-licenseplate-input").val() : null;
            if (storeCfg.abilityCustomLicensePlate && licensePlate.length == 0) {
                licensePlate = null;
            }
            let paymentMethod = $("#select-payment-method").val();
            $.post(`https://${GetParentResourceName()}/purchaseDone`, JSON.stringify({
                licensePlate: licensePlate,
                paymentMethod: paymentMethod,
                currentDate: currentDate
            }));
            setTimeout(() => {
                $(".resell").fadeOut(120);
                currentMenu = "showroom";
                canPurchase = true;
            }, 1000);
        } else {
            $.post(`https://${GetParentResourceName()}/resellDone`);
            setTimeout(() => {
                $(".resell").fadeOut(120);
                canPurchase = true;
                currentMenu = null;
            }, 1000);
        }
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
    
    if (currentMenu == "purchaseCard") {
        
        let licensePlate = storeCfg.abilityCustomLicensePlate ? $("#resell-licenseplate-input").val() : null;
        if (storeCfg.abilityCustomLicensePlate && (licensePlate.length != 8 && licensePlate.length != 0)) {
            $(".resell #resell-licenseplate-input").addClass("required");
            $(".resell #make_signature_buyer").show();
            return;
        };

        let paymentMethod = $("#select-payment-method").val();
        if (!paymentMethod) {
            $(".resell #select-payment-method").addClass("required");
            $(".resell #make_signature_buyer").show();
            return;
        }
    }
    canPurchase = false;
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

    let selectedColorPrimary = $("#select-color-primary").val();
    let selectedColorPrimaryName = $("#select-color-primary").find('option:selected').attr("name");
    
    let selectedColorSecondary = $("#select-color-secondary").val();
    let selectedColorSecondaryName = $("#select-color-secondary").find('option:selected').attr("name");

    let selectedColorPearlescent = $("#select-color-pearlescent").val();
    let selectedColorPearlescentName = $("#select-color-pearlescent").find('option:selected').attr("name");

    let paymentMethod = $("#select-payment-method").val();
    let price = $("#sell-price-input").val();
    let licensePlate = storeCfg.abilityCustomLicensePlate ? $("#resell-licenseplate-input").val() : null;

    if (!selectedBuyer) $(".resell #select-buyer").addClass("required");
    if (!selectedColorPrimary) $(".resell #select-color-primary").addClass("required");
    if (!selectedColorSecondary) $(".resell #select-color-secondary").addClass("required");
    if (!selectedColorPearlescent) $(".resell #select-color-pearlescent").addClass("required");
    if (!price) $(".resell #sell-price-input").addClass("required");
    if (!paymentMethod) $(".resell #select-payment-method").addClass("required");
    if (storeCfg.abilityCustomLicensePlate && (licensePlate.length != 8 && licensePlate.length != 0)) $(".resell #resell-licenseplate-input").addClass("required");

    if (selectedBuyer && selectedColorPrimary && selectedColorSecondary && selectedColorPearlescent && price && paymentMethod) {
        if (storeCfg.abilityCustomLicensePlate && (licensePlate.length != 8 && licensePlate.length != 0)) return;
        if (licensePlate == 0) {
            licensePlate = null;
        }
        $(".resell").fadeOut(150);
        $.post(`https://${GetParentResourceName()}/resellSend`, JSON.stringify({
            selectedBuyer: selectedBuyer,
            resellData: {
                sellerName: playerName,
                price: price,
                date: currentDate,
                brand: storeCfg.brand,
                address: storeCfg.address,
                licensePlate: licensePlate,
                paymentMethod: paymentMethod,
                vehicle: {
                    type: vehicleData.type,
                    brand: vehicleData.brand,
                    name: vehicleData.name,
                    model: vehicleData.model
                },
                colorPrimary: {
                    name: selectedColorPrimaryName,
                    id: selectedColorPrimary
                },
                colorSecondary: {
                    name: selectedColorSecondaryName,
                    id: selectedColorSecondary
                },
                colorPearlescent: {
                    name: selectedColorPearlescentName,
                    id: selectedColorPearlescent
                },
            }
        }));
    }
})

$(document).on('click', '.management-menu div[data-type="order"] .vehicles-filters button', function(e) {
    let vehBrand = $(".management-menu div[data-type='order'] #vehicle-brand-input").val().toUpperCase();
    let vehModel = $(".management-menu div[data-type='order'] #vehicle-model-input").val().toUpperCase();
    let minPrice = parseFloat($(".management-menu div[data-type='order'] #min-price-input").val());
    let maxPrice = parseFloat($(".management-menu div[data-type='order'] #max-price-input").val());

    $('.management-menu div[data-type="order"] .order-vehicles').each(function() {
        let brand = $(this).find('.brand-name').text().toUpperCase();
        let model = $(this).find('.model-name').text().toUpperCase();
        let priceText = $(this).find('.price').text();
        let price = parseFloat(priceText.replace(/[^\d.]/g, ''));

        let brandMatch = brand.includes(vehBrand);
        let modelMatch = model.includes(vehModel);
        let minPriceMatch = isNaN(minPrice) || price >= minPrice;
        let maxPriceMatch = isNaN(maxPrice) || price <= maxPrice;

        if (brandMatch && modelMatch && minPriceMatch && maxPriceMatch) {
            $(this).show();
        } else {
            $(this).hide();
        }
    });
});

$(document).on('click', '.showroom .vehicles-filters button', function(e) {
    let vehBrand = $(".showroom #vehicle-brand-input").val().toUpperCase();
    let vehModel = $(".showroom #vehicle-model-input").val().toUpperCase();
    let minPrice = parseFloat($(".showroom #min-price-input").val());
    let maxPrice = parseFloat($(".showroom #max-price-input").val());
    let category = $('.showroom .vehicles-filters select#vehicle-category').select2('data')[0]

    $('.showroom .vehicles-list > div').each(function() {
        let brand = $(this).find('.brand-name').text().toUpperCase();
        let model = $(this).find('.model-name').text().toUpperCase();
        let priceText = $(this).find('.price').text();
        let price = parseFloat(priceText.replace(/[^\d.]/g, ''));

        let categoryMatch = !category || category.id == 0 || category.id == $(this).data('category');
        let brandMatch = brand.includes(vehBrand);
        let modelMatch = model.includes(vehModel);
        let minPriceMatch = isNaN(minPrice) || price >= minPrice;
        let maxPriceMatch = isNaN(maxPrice) || price <= maxPrice;

        if (brandMatch && modelMatch && minPriceMatch && maxPriceMatch && categoryMatch) {
            $(this).show();
        } else {
            $(this).hide();
        }
    });
});

function balanceButton() {
    if ($('input[data-input="withdraw"]').val() >= 1) {
        let money = $('input[data-input="withdraw"]').val()
        $.post(`https://${GetParentResourceName()}/withdraw`, JSON.stringify({money: money}));
        $('input[data-input="withdraw"]').val('').hide();
        $('.btn[data-option="deposit"]').show();
        $('.btn[data-option="withdraw"]').show();
        $('.box[data-type="balance"] .close-balance').removeClass('isAnyVal');
        $('.box[data-type="balance"] .close-balance > i').removeClass('fa-check').addClass('fa-close');
        $('.box[data-type="balance"] .close-balance').removeClass('isVisible');
    } else if ($('input[data-input="deposit"]').val() >= 1) {
        let money = $('input[data-input="deposit"]').val()
        $.post(`https://${GetParentResourceName()}/deposit`, JSON.stringify({money: money}));
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

}

function updateManagement(newMenu, _this) {
    if (newMenu == currentMenu) return;

    if (newMenu != "employees") {
        $('.management-menu .main div[data-type="employees"] .box-right .data').empty();
    }

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
    $.post(`https://${GetParentResourceName()}/acceptOrder`, JSON.stringify({id: id}));
}

function hireEmployee(playerId) {
    if (playerId) {
        $.post(`https://${GetParentResourceName()}/hireEmployee`, JSON.stringify({playerId: playerId}));
    }
}

function bonusEmployee(identifier) {
    let bonusMoney = $("#bonus-money").val();
    if (identifier && bonusMoney && bonusMoney >= 1) {
        $.post(`https://${GetParentResourceName()}/bonusEmployee`, JSON.stringify({identifier: identifier, bonusMoney: bonusMoney}));
        $("#bonus-money").val('');
    }
}

function changeGradeEmployee(identifier, grade) {
    if (identifier && grade) {
        $.post(`https://${GetParentResourceName()}/changeGradeEmployee`, JSON.stringify({identifier: identifier, grade: grade}));
    }
}

function fireEmployee(identifier) {
    if (identifier) {
        $.post(`https://${GetParentResourceName()}/fireEmployee`, JSON.stringify({identifier: identifier}));
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

function sellVehicleCard(model) {
    vehicleData = storeCfg.vehicles[model]
    currentDate = getDate();
    currentMenu = "resell"
    $.post(`https://${GetParentResourceName()}/getClosestPlayers`, JSON.stringify({
        isInvoice: true
    }));

    $(".resell #give_invoice").css({
        "z-index": -500,
        "opacity": 0.0
    });
    
    $(".resell").show();
    $(".management-menu").hide();
    
    $(".resell .card #date > div").text(`${currentDate} - ${translation.resell_card.town}`);
    
    $(".resell .card .signatures .seller #give_invoice").text(translation.resell_card.give_contract_btn);

    $(".resell #signature_seller").text("")
    $(".resell #signature_buyer").text("")
    
    $(".resell #make_signature_seller").show();
    $(".resell #make_signature_buyer").hide();
}

let scrolledLeft, scrolledRight = false
$(document).on('keydown', 'body', function(e) {
    if (e.which == 27) {
        if (currentMenu == 'showroom') {
            $('.showroom').fadeOut(1500);
            $(".resell").fadeOut(150); 
        } else if (currentMenu == 'purchaseCard') {
            $(".resell").fadeOut(150); 
            $(".showroom").fadeIn(150); 
            currentMenu = "showroom";
            return;
        } else if (currentMenu == 'resell') {
            $('.resell').fadeOut(150);
        } else if (currentMenu == 'contract') {
            $(".contract").fadeOut(150);
        }
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({menu: currentMenu}));
        isMenuOpened = false;
        currentMenu = null
    }
    if (e.which == 69) {
        if (currentMenu != 'products') return;
        $('.select-products').hide(120);
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({menu: currentMenu}));
        isMenuOpened = false;
    }
    if (e.which == 37) {
        if (scrolledLeft) return;
        slider.scrollTo({ top: 0, left: slider.scrollLeft - 300, behavior: "smooth" });
        scrolledLeft = true
        setTimeout(() => {
            scrolledLeft = false
        }, 250);
    }
    if (e.which == 39) {
        if (scrolledRight) return;
        slider.scrollTo({ top: 0, left: slider.scrollLeft + 300, behavior: "smooth" });
        scrolledRight = true
        setTimeout(() => {
            scrolledRight = false
        }, 250);
    }
})


$(document).on('keypress', '#vehicle-brand-input', function(e) {
    if (event.key === "Enter") {
        event.preventDefault();
        document.getElementById(currentMenu == "showroom" ? "apply-filter-showroom" : "apply-filter-order").click();
    }
})

$(document).on('keypress', '#vehicle-model-input', function(e) {
    if (event.key === "Enter") {
        event.preventDefault();
        document.getElementById(currentMenu == "showroom" ? "apply-filter-showroom" : "apply-filter-order").click();
    }
})

$(document).on('keypress', '#min-price-input', function(e) {
    if (event.key === "Enter") {
        event.preventDefault();
        document.getElementById(currentMenu == "showroom" ? "apply-filter-showroom" : "apply-filter-order").click();
    }
})

$(document).on('keypress', '#max-price-input', function(e) {
    if (event.key === "Enter") {
        event.preventDefault();
        document.getElementById(currentMenu == "showroom" ? "apply-filter-showroom" : "apply-filter-order").click();
    }
})

var holdingRightButton = false

var oldx = 0;
var oldy = 0;

const showroomElement = document.querySelector(".showroom");
showroomElement.addEventListener('mousedown', function(event) {
    if (event.button == 2) {
        if ($('.showroom > .vehicles-list').is(':hover')) return;
        oldx = event.clientX
        oldy = event.clientY
        holdingRightButton = true;
    }
});

showroomElement.addEventListener('mouseup', function(event) {
    if (holdingRightButton && event.button == 2) {
        holdingRightButton = false;
    }
});

showroomElement.addEventListener('mousemove', function (event) {
    if (holdingRightButton) {
        var deltaX = event.clientX - oldx;
        var deltaY = event.clientY - oldy;
        if (deltaX !== 0 || deltaY !== 0) {
            var direction = '';
            var absDeltaX = Math.abs(deltaX);
            var absDeltaY = Math.abs(deltaY);

            if (absDeltaX > absDeltaY) {
                if (deltaX > 0) {
                    direction = 'right';
                } else {
                    direction = 'left';
                }
            } else {
                if (deltaY > 0) {
                    direction = 'bottom';
                } else {
                    direction = 'top';
                }
            }

            oldx = event.clientX;
            oldy = event.clientY;

            $.post(`https://${GetParentResourceName()}/updateCamera`, JSON.stringify({
                deltaX: deltaX,
                deltaY: deltaY
            }));
        }
    }
});

showroomElement.addEventListener("wheel", (e) => {
    if ($('.showroom > .vehicles-list').is(':hover')) return;
    var zoom = e.deltaY > 1 && 'minus' || 'plus'
    $.post(`https://${GetParentResourceName()}/updateCameraZoom`, JSON.stringify({type: zoom}));
})

$('.showroom .vehicles-filters select#vehicle-category').on('select2:select', function (e) {
    $('.showroom .vehicles-filters button').click();
});

$(document).on('click', '.showroom .test-drive-btn', function(e) {
    testDrive()
});

function testDrive(model) {
    if (!canPurchase) return;
    if (!canSelectNewVehicle) return;
    $.post(`https://${GetParentResourceName()}/testDrive`, JSON.stringify({
        menu: currentMenu,
        model: model || null
    }));
}

function pickColor(type, index) {
    $(`.color-selector[data-type="${type}"] .colors-grid span.color`).removeClass("active");
    $(`.color-selector[data-type="${type}"] .colors-grid span.color[data-id="${index}"]`).addClass('active');

    $.post(`https://${GetParentResourceName()}/pickColor`, JSON.stringify({type: type, index: index}));
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

function checkPlateInput(input) {
    let inputValue = input.value;
    const regex = /^[a-zA-Z0-9\s]*$/;
    inputValue = inputValue.toUpperCase();
    input.value = inputValue;

    if (inputValue.length > 8) {
        input.value = inputValue.slice(0, 8);
    } else if (!regex.test(inputValue)) {
        input.value = inputValue.replace(/[^a-zA-Z0-9\s]/g, '');
    }
}


function getDate() {
    var currentDate = new Date();

    var year = currentDate.getFullYear();
    var month = currentDate.getMonth() + 1; // Pamiętaj, że miesiące są numerowane od 0 do 11, dlatego dodajemy 1
    var day = currentDate.getDate();
    var hours = currentDate.getHours();
    var minutes = currentDate.getMinutes();
    if (minutes < 10) {
        minutes = '0' + minutes;
    }
    var formattedDateTime = (`{0}.{1}.{2} {3}:{4}`).format(day, month, year, hours, minutes);

    return formattedDateTime;
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