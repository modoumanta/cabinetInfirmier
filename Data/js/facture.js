function openFacture(prenom, nom, actes) {
    var width = 500;
    var height = 300;
    var left = (window.innerWidth - width) / 2;
    var top = (window.innerHeight - height) / 2;

    // Crée une nouvelle fenêtre pour afficher la facture
    var factureWindow = window.open('', 'facture',
        'menubar=yes, scrollbars=yes, top=' + top + ', left=' + left + ', width=' + width + ', height=' + height);

    // Formatage de la facture
    var factureText = afficherFacture(prenom, nom, actes);

    // Insère le contenu dans la nouvelle fenêtre
    factureWindow.document.write('<html><head><title>Facture</title></head><body>');
    factureWindow.document.write(factureText);
    factureWindow.document.write('</body></html>');
}

// Fonction d'amélioration pour formater la facture
function afficherFacture(prenom, nom, actes) {
    return `
        <h1 style="color: #0D47A1; text-align: center;">Facture</h1>
        <p><strong>Patient :</strong> ${prenom} ${nom}</p>
        <p><strong>Acte Médical :</strong> ${actes}</p>
        <p style="margin-top: 20px; font-size: 14px; color: #555;">Merci pour votre confiance.</p>
    `;
}
