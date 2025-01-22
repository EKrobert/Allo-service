
    document.addEventListener("DOMContentLoaded", function() {
        var input = document.querySelector("#phone");
        var countryCodeInput = document.querySelector("#country_code");

        var iti = window.intlTelInput(input, {
            separateDialCode: true,
            utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"
        });


        function handleFormSubmit(event) {
            event.preventDefault();

            // Récupéreration du code de pays avec le préfixe "+"
            var countryCode = "+" + iti.getSelectedCountryData().dialCode;

            // Récupéreration du numéro de téléphone
            // var phoneNumber = input.value;

            // Valider le numéro de téléphone côté client
            var isValidPhoneNumber = iti.isValidNumber();

            if (!isValidPhoneNumber) {
                // Afficher le message d'erreur dans le span
                var phoneErrorSpan = document.getElementById("phone-error");
                phoneErrorSpan.textContent = "Numéro de téléphone invalide";
                return;
            }

            // Réinitialiser le message d'erreur s'il était précédemment affiché
            // eslint-disable-next-line no-redeclare
            var phoneErrorSpan = document.getElementById("phone-error");
            phoneErrorSpan.textContent = ""; // Réinitialiser le contenu du span

            // Mettre à jour les valeurs des champs cachés
            countryCodeInput.value = countryCode;
            // Soumettre le formulaire
            event.target.submit();
        }

        // Réinitialiser le message d'erreur lorsque l'utilisateur modifie le champ de téléphone
        input.addEventListener("input", function() {
            var phoneErrorSpan = document.getElementById("phone-error");
            phoneErrorSpan.textContent = ""; // Réinitialiser le contenu du span
        });

        var form = document.querySelector("form");
        form.addEventListener("submit", handleFormSubmit);
    });