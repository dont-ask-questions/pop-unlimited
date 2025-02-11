function rgb2hex(rgb){
 rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
 return (rgb && rgb.length === 4) ? "0x" +
  ("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
  ("0" + parseInt(rgb[2],10).toString(16)).slice(-2) +
  ("0" + parseInt(rgb[3],10).toString(16)).slice(-2) : '';
}

function convertHex(hex){
    hex = hex.replace('#','');
    r = parseInt(hex.substring(0,2), 16);
    g = parseInt(hex.substring(2,4), 16);
    b = parseInt(hex.substring(4,6), 16);

    s = Math.floor(r*.8);
    t = Math.floor(g*.8);
    u = Math.floor(b*.8);
   result = 'rgb('+s+','+t+','+u+')';
    return result;
}


function getLook() {
      username = document.getElementById('username').value;
      password = MD5(document.getElementById('password').value.toLowerCase());
      partTypes = [""];
    if ( document.getElementById("dropdownlist").selectedIndex == "1") {
    partTypes[0] = document.getElementById("dropdownlist").value;
    partTypes[1] = "lineColor";
    }else {
    partTypes[0] = document.getElementById("dropdownlist").value;
    }
    newPartNames = [""];
    if ( document.getElementById("dropdownlist").selectedIndex == "1") {
    newPartNames[0] = parseInt(document.getElementById("colors").value.replace("#","0x"), 16);
    newPartNames[1] = parseInt(rgb2hex(convertHex(document.getElementById("colors").value)), 16);
    }
    newPartNames[0] = parseInt(document.getElementById("colors").value.replace("#","0x"), 16);
    var user = btoa("000000" + btoa(username));
     $.ajax({
    type: "POST",
    url: "https://pop-proxy-2020.herokuapp.com/https://www.poptropica.com/get_embedInfo.php",
    data: {
         a: user
    },
    dataType:"text",
    success: function(data) {

            var b = decodeURIComponent(data.replace("%26", "%40"));
            var d = b.replace(/@/g, "%26");
            var c = d.replace("look=", "");
            var a = c.split("&")[1];
            changeLook(a);
          },
        error: function() {
           document.getElementById("status").innerHTML = "invalid username";
          },
       });
     };
function changeLook(a) {
    partTypeNames = ["gender", "skinColor", "hairColor", "lineColor", "eyelidPos", "eyes", "marks", "pants", "lineWidth", "shirt", "hair", "mouth", "item", "pack", "facial", "overshirt", "overpants", "specialAbility"];
    newLook = new Array();
    nameArrayValues(partTypeNames.slice(0), a.split(","));
    editedLook = nameArrayValues(partTypes, newPartNames);
    finalLook = "";
    for (counter = 0; counter < 18; counter++) {
        finalLook += editedLook[partTypeNames[counter]] + ",";
        editedLook.splice(0, 1)
    }

  if(document.getElementById("Yes").checked == true) {
 sendData2(finalLook.substr(0, finalLook.length - 1));
 } else if (document.getElementById("No").checked == true){
sendData(finalLook.substr(0, finalLook.length - 1));
} else {
return;
}

function nameArrayValues(a, b) {
    while (a.length > 0) {
        newLook[a[0]] = b[0];
        a.splice(0, 1);
        b.splice(0, 1);
    }
    return newLook
}

function sendData(a){

            $.ajax({
                 type:"POST",
                  url: "https://pop-proxy-2020.herokuapp.com/https://poptropica.com/change_look.php",
                  data: {
                        login: username,
                        pass_hash: password,
                        look: a,
						dbid: "4"
                      },
                   dataType: "text",
                    success: function() {
                       var user = btoa("000000" + btoa(username));
                       embed = "<embed base='http://static.poptropica.com/avatarstudio/' wmode='transparent' width='169' height='236' style='margin-left:30px;' src=http://static.poptropica.com/avatarstudio/charEmbed.swf?a=b" + user + "><embed>";
                       document.getElementById("status").innerHTML = embed;
                      },
                      error: function(data) {
                       document.getElementById("status").innerHTML = data;
                      }
                  });
                }

function sendData2(a) {
     $.ajax({
                 type:"POST",
                  url: "https://pop-proxy-2020.herokuapp.com/https://poptropica.com/lookCloset/save_user_look.php",
                  data: {
                        login: username,
                        pass_hash: password,
                        look:  a, 
                        look_type: "5020",
						dbid: "4"
                      },
                   dataType: "text",
                success: function() {
                      embed2 ="<p style='font-weight:bold;color=#0000FF;'>Yay!!Check your closet!</p>";
                   document.getElementById("status2").innerHTML = embed2;
                      },
                      error: function(data) {
                       document.getElementById("status2").innerHTML = data;
                      }
                  });
                }
               }
			   