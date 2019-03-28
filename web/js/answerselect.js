/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var optionselect;

function selectit(option){
    var nid = option.id;
    highlight(nid[nid.length - 1]);
    this.optionselect = option;
}

function highlight(mark){
    document.getElementById("mark" + mark).style.backgroundColor = "yellow";

    for(var i=1; i<5; i++){
        if(i != mark)
            document.getElementById("mark"+i).style.backgroundColor = "";
    }
}
