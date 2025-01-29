/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function generatePagger(id,pageindex,totalpage,gap)
{
    var container = document.getElementById(id);
    var content = "";
    
    if(pageindex > gap)
        content += "<input type=\"button\" value=\"First\" onclick=\"changePage(1);\" />";
    
    for(var i= pageindex - gap ; i < pageindex;i++)
        if(i > 0)
            content += "<input type=\"button\" value=\""+i+"\" onclick=\"changePage("+i+");\" />";
    
    content += "<span>"+pageindex+"</span>";
    
    for(var i= pageindex +1 ; i <= pageindex+gap;i++)
        if(i <= totalpage)
            content += "<input type=\"button\" value=\""+i+"\" onclick=\"changePage("+i+");\" />";
    
    if(pageindex + gap < totalpage)
        content += "<input type=\"button\" value=\"Last\" onclick=\"changePage("+totalpage+");\" />";
    
    container.innerHTML = content;
}

function changePage(page)
{
    window.location.href='customer-list?page='+page;
}


