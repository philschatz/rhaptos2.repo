
// :author: pbrian <paul@mikadosoftware.com>
// :JQuery scripts for ednamode project for CNX.org
// NB: assume conf.js is included earlier ...



    var REPOBASEURL="http://" + FROZONE.e2repoFQDN ;
    var MODULEURL="http://" + FROZONE.e2repoFQDN + "/module/";
    var WORKSPACEURL="http://" + FROZONE.e2repoFQDN + "/workspace/";



    function logout(msg){
        //log to a HTML area all messages

        var txt = $("#logarea").html();
        $("#logarea").html(txt + "<li> " + msg);
    };

    function get_username(){
        return $('#username').val();
    };

    function get_title(){
        var mname = $('#title').val();
        return mname;
    };

function save_validate(){
    var title=get_title();
    if (title = ''){
        jQuery.error('Must have a title');
    }
    return
}

    function get_textarea_html5(){
        //retrieve, as JSON, the contents of the edit-area 
        var txtarea = $('#e2textarea').tinymce().getContent();
        return txtarea;
    };


    function load_textarea(title){
        
        var request =$.ajax({
	    url: MODULEURL + mhashid,

	xhrFields: {
	    withCredentials: true
       	},  //http://stackoverflow.com/questions/2870371/why-jquery-ajax-not-sending-session-cookie

            type: 'GET'
        });

	request.done(function(data) {
	    logout(data + 'done a success');
            $('#e2textarea').tinymce().setContent(data);
	});

	request.fail(function(jqXHR, textStatus, err) {
	    logout( "Request failed: " + textStatus + ":" + err + ":" +  jqXHR.status);
	});

	request.always(function(jqXHR, textStatus){
	    logout(textStatus);
	});
    };


function getLoadHistoryVer(uuid){
    // ajax request to retrieve module and parse json and load into textarea
    $.ajax({
        type: "GET",
        dataType: 'json',
        url: MODULEURL + uuid,
	xhrFields: {
	    withCredentials: true
	},  //http://stackoverflow.com/questions/2870371/why-jquery-ajax-not-sending-session-cookie


        success: function(nodedoc){
            var title = nodedoc['title'];
            var txtarea = nodedoc['content'];
 
            var aclrw = nodedoc['aclrw'];
            var contentrw = nodedoc['contentrw'];

            $('#title').val(title);
            $('#aclrw').val(aclrw);
            $('#contentrw').val(contentrw);
            $('#uuid').val(uuid);

            $('#e2textarea').tinymce().setContent(txtarea);
        },

        error: function(jqXHR, textStatus, err) {
            logout( "Request failed: " + textStatus + ":" + err + ":" +  jqXHR.status);
        },

        complete: function(jqXHR, textStatus, err) {
            logout( "Complete: Request failed: " + textStatus + ":" + err + ":" +  jqXHR.status);
        },


    });    
}


function getwhoami(){
    // ajax request
    $.ajax({
        type: "GET",
        dataType: 'json',
        url: REPOBASEURL + "/whoami/",
	xhrFields: {
	    withCredentials: true
	},  //http://stackoverflow.com/questions/2870371/why-jquery-ajax-not-sending-session-cookie
        
        success: function(module){
            var user_email = module['user_email'];
            var user_name = module['user_name'];
            //alert(user_email + user_name);
            $('#usernamedisplay').html(user_name + "-" + user_email);
        },

        error: function(jqXHR, textStatus, err) {
            logout( "Request failed: " + textStatus + ":" + err + ":" +  jqXHR.status);
        }

    });    
}




function buildHistory(){

    var htmlfrag = '<ul>'
    $.ajax({
        type: "GET",
        dataType: 'json',
        url: WORKSPACEURL,
	xhrFields: {
	    withCredentials: true
	},  //http://stackoverflow.com/questions/2870371/why-jquery-ajax-not-sending-session-cookie

        success: function(historyarr){
            historyarr.sort();
            $.each(historyarr, function(i,elem){
                var strelem = "'" + elem[0] + "'";
		htmlfrag += '<li><a class="nolink" href="#" onclick="getLoadHistoryVer(' + strelem + ');" >' + elem[1] + '</a>' + '<a class="nolink" href="#" onclick="delete_module(' + strelem + ');" >(Delete)</a>';
            });

            $('#workspaces').html(htmlfrag);    
        }
    });    
};

function delete_module(filename){
    $.ajax({
        type: "DELETE",
        dataType: 'json',
        url: REPOBASEURL + "/module/" + filename,
	xhrFields: {
	    withCredentials: true
	},  //http://stackoverflow.com/questions/2870371/why-jquery-ajax-not-sending-session-cookie
        
        success: function(){
            logout("deleted " + filename);
            buildHistory();            
        },

        error: function(jqXHR, textStatus, err) {
            logout( "Request failed: " + textStatus + ":" + err + ":" +  jqXHR.status);
        }

    });    

}

function showres(i, elem){

    logout(i + ': ' + elem);
};


function serialise_form(){
    // return form1 as object/hasharrary
    var payload = new Object;
    payload['content'] = get_textarea_html5();
    payload['uuid'] = $("#uuid").val();
    
    payload['aclrw'] = $("#aclrw").val().split(",");
    
    payload['contentrw'] = $("#contentrw").val().split(",");
    payload['title'] = $("#title").val();

//        var json_text = JSON.stringify(payload, null, 2);
//        return json_text;

    return payload;

};

function saveText(){
	 //constants

         save_validate();
         
         var requestmethod = 'POST';
         var payload = serialise_form(); 
         
     
         for (var i in payload){                  
             alert(i + ' : ' + payload[i]);
         };

         var json_text = JSON.stringify(payload, null, 2);

	 var request = $.ajax({
	     url: MODULEURL,
        	xhrFields: {
	         withCredentials: true
	        },  //http://stackoverflow.com/questions/2870371/why-jquery-ajax-not-sending-session-cookie


	     type: requestmethod,
             data: json_text,
             contentType:"application/json; charset=utf-8",
             dataType:'json'
	 });

	 request.done(function(data) {
	     //$("#responsearea").html(data);
             $.each(data, showres);
             buildHistory();
	 });

	 request.fail(function(jqXHR, textStatus, err) {
	     logout( "Request failed: " + textStatus + ":" + err + ":" +  jqXHR.status);
	 });

	 request.always(function(jqXHR, textStatus){
	     logout(textStatus);
	 });

    };





$(document).ready(function() {

    //bind various clicks

    $("#clickLoadTextArea").click(function(e){load_textarea();
                                              e.preventDefault()});

    logout('AJAX will fire at ' + MODULEURL);    
    buildHistory();    
    getwhoami();    

    //nolink are links that do some jquery function, but should not be links
    $("a.nolink").click(function(event){
        logout('click-preventDefault');
	event.preventDefault();
    });

    $("#save").click(function(event){
                         saveText();
                         event.preventDefault();
                       }
                      );

  
});


