loadCategoryFilter = (categories) => {
    if (!categories) {
        $('.showroom .vehicles-filters select#vehicle-category').hide();
        return;
    }
    $('.showroom .vehicles-filters select#vehicle-category').show();

    const categoriesData = [];
    categoriesData.push({
        id: 0,
        text: translation.filters.category_all,
        selected: true
    })
 
    for (const [k, v] of Object.entries(categories)) {
        categoriesData.push({
            id: k,
            text: v
        })
    };
    
    $('.showroom .vehicles-filters select#vehicle-category').select2({
        allowClear: false,
        data: categoriesData
    });

}

loadVehiclesOnDisplay = () => {
    let vehcilesList = `<option value="">${translation.vehicles_on_display.no_selected}</option>`
    for (const [k, v] of Object.entries(storeData.stock)) {
        if (v && v.count >= 1) {
            vehcilesList += `
                <option value="${k}">${storeCfg.vehicles[k].brand} ${storeCfg.vehicles[k].name}</option>
            `
        }
    };

    let vehiclesOnDisplayData = ''
    for (const [id, val] of Object.entries(storeCfg.vehiclesOnDisplay)) {
        let crntId = Number(id) + 1
        vehiclesOnDisplayData += `
            <div data-id="${crntId}">
                <div class="display-id">${crntId}</div>

                <select>
                    ${vehcilesList}
                </select>

                <div class="change_btn" data-id="${crntId}">
                    <p>
                        ${translation.vehicles_on_display.change_btn}
                    </p>
                </div>
            </div>
        `

    };
    $('.management-menu div[data-type="vehicles-on-display"] > div').html(vehiclesOnDisplayData);

    for (const [id, val] of Object.entries(storeCfg.vehiclesOnDisplay)) {
        let crntId = Number(id) + 1
        if (storeData.data.vehiclesOnDisplay[String(crntId)]) {
            $(`.management-menu div[data-type="vehicles-on-display"] > div > div[data-id="${crntId}"] select > option[value="${storeData.data.vehiclesOnDisplay[String(crntId)]}"]`).attr('selected', true)
        }
    };

    $('.management-menu .side-bar > div[data-href="vehicles-on-display"]').show();
}

loadAnnoucements = (announcements) => {
    let announcementsData = ''
    for (const [k, v] of Object.entries(announcements)) {
        if (v) {
            announcementsData = announcementsData + `
                <div ${v.type && `class="${v.type}"` || ''}>
                    <div class="user ${v.type && `${v.type}` || ''}">
                        <div class="avatar"><i class="${!v.type && "fa-solid fa-user"}"></i></div>
                        <div class="name">${v.name}</div>
                    </div>
                    <div class="message">${v.message}</div>
                </div>
            `
        }
    }
    return announcementsData;
}

loadBestsellers = (stock) => {
    const productsArray = [...Object.entries(stock)];
    productsArray.sort((a, b) => (b[1]?.sold || 0) - (a[1]?.sold || 0));
    const bestsellers = productsArray.slice(0, 8);
    let bestSellersData = ''
    bestsellers.forEach(([k, v]) => {
        if (v && v.sold >= 1) {
            var vehData = storeCfg.vehicles[k]
            bestSellersData = bestSellersData + `
                <div>
                    <span class="label">${vehData.brand} ${vehData.name}</span>
                    <span class="count">${v.sold}${translation.quantity}</span>
                </div>
            `
        }
    })
    return bestSellersData;
}

loadStock = (stock) => {
    let stockData = ''
    for (const [k, v] of Object.entries(stock)) {
        if (k && storeCfg.vehicles[k]) {
            stockData = stockData + `
                <div class="product ${v.count <= 0 ? `lack-of-stock` : ''}">
                    <div class="info">
                        <div class="label">${storeCfg.vehicles[k].brand} ${storeCfg.vehicles[k].name}</div>
                    </div>
                    ${(storeCfg.vehicles[k].brand && config.brandsLogos[storeCfg.vehicles[k].brand]) ? `<img src="/html/icons/brands/${config.brandsLogos[storeCfg.vehicles[k].brand]}" draggable="false">` : ``}
                    <div class="icon">
                        <img src="/html/icons/vehicles/${k}.webp" draggable="false">
                    </div>
                    <div class="information">
                        <div class="sell-vehicle" ${v.count >= 1 ? `onclick="sellVehicleCard('${k}')"` : ''}>${translation.stock.sell_vehicle}</div>
                        <div class="test-drive" ${v.count >= 1 ? `onclick="testDrive('${k}')"` : ''}>${translation.stock.test_drive}</div>
                        <div>${translation.stock.stock} <span>${v.count}</span></div>
                    </div>
                </div>
            `
        }
    }
    return stockData;
}

loadOrders = (orders, ordersAccepted) => {
    let ordersData = ''

    for (const [k, v] of Object.entries(orders)) {
        let vehicles = ""
        let deliveryTime = ""
        if (v.orderTime) {
            var date = new Date((v.orderTime * 1000) + (storeCfg.orderDeliveryTime * 60 * 1000));
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var hours = date.getHours();
            var minutes = date.getMinutes();
            deliveryTime = year + "-" + month + "-" + day + " " + hours + ":" + minutes
        }
        for (const [_, val] of Object.entries(v.vehicles)) {
            vehicles = `${vehicles} ${val.brand} ${val.name},`
        }
        ordersData = ordersData + `
            <tr>
                <td class="table-first">${vehicles}</td>
                ${storeCfg.realisticDelivery ? `
                    <td class="table-last">
                        ${(ordersAccepted && ordersAccepted[k]) ? `<div class="accepted-order">${translation.orders.table_option_accepted}</div>` : `<div data-option="accept-order" onclick="acceptOrder('${k}')">${translation.orders.table_option_accept}</div>`}
                    </td>
                ` : `
                    <td class="table-last">
                        ${v.orderTime ? `
                            <div>${translation.orders.delivery_time} <b>${deliveryTime}</b></div>
                        ` : `
                            <div data-option="accept-order" onclick="acceptOrder('${k}')">${translation.orders.table_option_accept}</div>
                        `}
                    </td>
                `}
            </tr>
        `
    }
    return ordersData;
}

loadOrder = (vehicles) => {
    let orderData = ''
    for (const [k, v] of Object.entries(vehicles)) {
        orderData = orderData + `
            <div class="order-vehicles" data-category="${v.categoryLabel}" data-orderprice="${v.orderprice}">
                ${(v.brand && config.brandsLogos[v.brand]) ? `<img class="brand-logo" src="/html/icons/brands/${config.brandsLogos[v.brand]}" draggable="false">` : ``}
                <div class="vehicle-img">
                    <img src="/html/icons/vehicles/${v.model}.webp" draggable="false">
                </div>
                <div class="informations">
                    <div class="model">
                        <span class="brand-name">${v.brand}</span>
                        <span class="model-name">${v.name}</span>
                    </div>
                    <div class="price">
                        <span>${number.format(v.orderprice)}${translation.currency}</span>
                    </div>
                </div>
                <div class="btn" id="btn" onclick="addToOrder('${v.model}')">
                    <p>${translation.order.add_to_order}</p>
                </div>
            </div>
        `
    }
    return orderData;
}

loadEmployees = (employees) => {
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
    return employeesData;
}

loadSalesHistory = (historySales) => {
    let salesHistoryData = '';
    for (const [k, v] of Object.entries(historySales)) {
        salesHistoryData = salesHistoryData + `
            <tr>
                <td class="table-first">${v.date}</td>
                <td>${v.seller}</td>
                <td>${v.buyer}</td>
                <td>${v.vehicle}</td>
                <td>${v.price}${translation.currency}</td>
            </tr>
        `
    }
    return salesHistoryData;
}

let balanceAlreadyRemoved = false
loadBalance = (balance) => {
    if (useBuildInBalance) {
        $('.management-menu div[data-type="boss-management"] div[data-type="balance"] .title').html(`${translation.currency} ${number.format(balance)}`);
    } else {
        if (!balanceAlreadyRemoved && removeBalanceFromMenu) {
            var element = document.querySelector('.management-menu div[data-type="boss-management"] div[data-type="balance"]');
            if (element) element.remove();

            $('.management-menu div[data-type="boss-management"] .header-buttons').css({'grid-template-columns': 'auto'})
            $('.management-menu div[data-type="boss-management"] div[data-type="employees-count"]').css({'width': '100%'})

            balanceAlreadyRemoved = true;
        }
        if (!removeBalanceFromMenu) {
            $('.management-menu div[data-type="boss-management"] div[data-type="balance"] .title').html(`${translation.currency} ${number.format(balance)}`);
        }
    }
}