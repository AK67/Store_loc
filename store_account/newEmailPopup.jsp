<!-- template for new emailPopup according to new wireframe -->
<!-- stylesheet -> storecommon.css   -->
<!-- declaring id with prefix _EP corresponding to email popup to prevent accidental overriding of elements sharing same name-->
<script>
function fire() {
var email = document.getElementById('email_EC').value;
var notes = document.getElementById('notes_EC').value;
var id = document.getElementById('hiddenId').value;
newEmailer(id, email, notes);
}
</script>
<div id='emailoverlay'>
<div id="logmsk" style="display: block;">
<div id="userbox">
<h1 id="signup">Send Email</h1>
<input id="email_EC" placeholder="Email ID">
<textarea id="notes_EC" rows="5" cols="25"  placeholder="Notes"></textarea>
<input type="hidden" id="hiddenId" />
<button id="signupb" onclick="fire();" style="cursor: default;">Email</button>&nbsp;<button id="signupc" onclick="closepopUP_EP();" style="cursor: default;">Cancel</button>
</div>
</div>
</div>
<div id='fade'></div>
