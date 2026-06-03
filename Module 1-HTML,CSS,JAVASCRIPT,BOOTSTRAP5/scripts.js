// ```javascript
// // Module 1 JavaScript Exercises
// // Local Community Event Portal
        let formChanged = false;

        document.getElementById("registrationForm").addEventListener("change", function () {
            formChanged = true;
        });

        function registerUser(event) {
            event.preventDefault();
            let name = document.getElementById("name").value;
            document.getElementById("confirmationMessage").innerHTML = "Thank you, " + name + ". Your registration is submitted.";
            sessionStorage.setItem("lastRegisteredUser", name);
            formChanged = false;
            console.log("Registration form submitted by " + name);
        }

        function validatePhone() {
            let phone = document.getElementById("phone").value;
            let error = document.getElementById("phoneError");

            if (phone.length !== 10 || isNaN(phone)) {
                error.innerHTML = "Please enter a valid 10 digit phone number.";
            } else {
                error.innerHTML = "";
            }
        }

        function showEventFee() {
            let eventType = document.getElementById("eventType").value;
            let feeText = "";

            if (eventType === "Cultural Event") {
                feeText = "Event Fee: ₹100";
            } else if (eventType === "Music Night") {
                feeText = "Event Fee: ₹150";
            } else if (eventType === "Park Clean Up") {
                feeText = "Event Fee: Free";
            } else if (eventType === "Workshop") {
                feeText = "Event Fee: ₹200";
            }

            document.getElementById("feeDisplay").innerHTML = feeText;
        }

        function buttonConfirmation() {
            console.log("Register button clicked");
        }

        function enlargeImage(image) {
            image.style.width = "260px";
            image.style.height = "180px";
        }

        function countCharacters() {
            let message = document.getElementById("message").value;
            document.getElementById("charCount").innerHTML = message.length;
        }

        function countFeedbackCharacters() {
            let feedback = document.getElementById("feedback").value;
            document.getElementById("feedbackCount").innerHTML = feedback.length;
        }

        function videoReady() {
            document.getElementById("videoMessage").innerHTML = "Video ready to play";
        }

        function savePreference() {
            let selectedEvent = document.getElementById("eventType").value;
            localStorage.setItem("preferredEvent", selectedEvent);
        }

        window.onload = function () {
            let savedEvent = localStorage.getItem("preferredEvent");
            if (savedEvent) {
                document.getElementById("eventType").value = savedEvent;
                showEventFee();
            }
        };

        function clearPreferences() {
            localStorage.clear();
            sessionStorage.clear();
            alert("Preferences cleared successfully.");
        }

        function findNearbyEvents() {
            let result = document.getElementById("locationResult");

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError, {
                    enableHighAccuracy: true,
                    timeout: 5000,
                    maximumAge: 0
                });
            } else {
                result.innerHTML = "Geolocation is not supported by this browser.";
            }
        }

        function showPosition(position) {
            document.getElementById("locationResult").innerHTML =
                "Latitude: " + position.coords.latitude + "<br>Longitude: " + position.coords.longitude;
        }

        function showError(error) {
            let result = document.getElementById("locationResult");

            if (error.code === error.PERMISSION_DENIED) {
                result.innerHTML = "Location permission denied by user.";
            } else if (error.code === error.TIMEOUT) {
                result.innerHTML = "Location request timed out.";
            } else {
                result.innerHTML = "Unable to get location.";
            }
        }

        function warnBeforeLeaving() {
            if (formChanged) {
                return "You have unfinished form details. Are you sure you want to leave?";
            }
        }