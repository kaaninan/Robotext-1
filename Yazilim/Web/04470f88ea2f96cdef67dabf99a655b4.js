!function(){var a;$(function(){var a;return a={element:"areachart",behaveLikeLine:!0,data:[{x:"2011-01",y:15,z:7},{x:"2011-02",y:26,z:4},{x:"2011-03",y:21,z:18},{x:"2011-04",y:32,z:18},{x:"2011-05",y:15,z:7},{x:"2011-06",y:26,z:4},{x:"2011-07",y:18,z:14},{x:"2011-08",y:36,z:11},{x:"2011-09",y:15,z:12},{x:"2011-10",y:26,z:4},{x:"2011-11",y:28,z:11},{x:"2011-12",y:36,z:14}],xkey:"x",ykeys:["y","z"],labels:["Y","Z"],lineColors:["#f9c1c1","#c1daf9"]},Morris.Area(a),$(".dynamicsparkline").sparkline([10,8,5,7,5,4,1,10,8,12,7,7,4,5,8,8,7,7,11,5,9,12,7,7,4,5,8,8],{type:"line",lineColor:"#89b1e4",fillColor:"#d7e8fc"}),$(".dynamicbars").sparkline([5,6,7,2,0,-4,-2,4,1,10,8,12,7,-2,4,8],{type:"bar",barColor:"#89b1e4",negBarColor:"#c76868"}),$(".knob").knob({thickness:".05",font:"Open Sans",bgColor:"#f3eee7",readOnly:!0}),$(window).resize(function(){return $("#areachart").html(""),Morris.Area(a)})}),a=function(){var a,e,o,r,n,t,l;return t=google.visualization.arrayToDataTable([["Task","Hours per Day"],["Floor Lamps",5],["Sofa Beds",3],["Laptops",2],["Chairs",7]]),l={backgroundColor:"transparent",colors:["#e87879","#71b9e3","#7fc899","#9c7cb8"],fontSize:14,fontName:"Open Sans",chartArea:{left:0,top:0,width:"100%",height:"100%"}},n=new google.visualization.PieChart(document.getElementById("piechart")),n.draw(t,l),a=google.visualization.arrayToDataTable([["Year","Sales","Expenses"],["2010",1e3,400],["2011",1170,460],["2012",660,1120]]),e={backgroundColor:"transparent",colors:["#e87879","#71b9e3","#7fc899","#9c7cb8"],width:"100%",fontName:"Open Sans"},n=new google.visualization.ColumnChart(document.getElementById("topsellers_barchart")),n.draw(a,e),o=google.visualization.arrayToDataTable([["Year","Sales","Expenses"],["2008",340,700],["2009",500,200],["2010",1e3,400],["2011",1170,460],["2012",660,1120]]),r={backgroundColor:"transparent",colors:["#e87879","#71b9e3","#7fc899","#9c7cb8"],width:"100%",fontName:"Open Sans"},n=new google.visualization.ColumnChart(document.getElementById("barchart")),n.draw(o,r)},google.load("visualization","1",{packages:["corechart"]}),google.setOnLoadCallback(a)}.call(this);
;