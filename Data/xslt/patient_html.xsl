<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.univ-grenoble-alpes.fr/l3miage/medical"
                exclude-result-prefixes="xsl">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Modèle principal -->
    <xsl:template match="/Patient">
        <html>
            <head>
                <title>Fiche Patient</title>
                <style>
                    body {
                    font-family: Arial, sans-serif;
                    background-color: #f0f4f8;
                    color: #333;
                    margin: 0;
                    padding: 20px;
                    }
                    h1 {
                    text-align: center;
                    color: #1b2a4e;
                    font-size: 24px;
                    text-transform: uppercase;
                    margin-bottom: 20px;
                    }
                    .card {
                    background-color: #ffffff;
                    border-left: 5px solid #1b2a4e;
                    margin: 20px auto;
                    padding: 15px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    width: 50%;
                    border-radius: 8px;
                    }
                    .header {
                    font-weight: bold;
                    color: #1b2a4e;
                    margin-bottom: 5px;
                    font-size: 16px;
                    }
                    .value {
                    color: #333;
                    margin-bottom: 10px;
                    }
                    .visit {
                    background-color: #e7f3fe;
                    border: 1px solid #b3d8ff;
                    padding: 10px;
                    border-radius: 5px;
                    margin-top: 10px;
                    }
                </style>
            </head>
            <body>
                <h1>Fiche Patient</h1>
                <div class="card">
                    <div class="header">Nom :</div>
                    <div class="value"><xsl:value-of select="nom"/></div>

                    <div class="header">Prénom :</div>
                    <div class="value"><xsl:value-of select="prenom"/></div>

                    <div class="header">Sexe :</div>
                    <div class="value"><xsl:value-of select="sexe"/></div>

                    <div class="header">Date de naissance :</div>
                    <div class="value"><xsl:value-of select="naissance"/></div>

                    <div class="header">Adresse :</div>
                    <div class="value">
                        <xsl:value-of select="adresse/rue"/>, <xsl:value-of select="adresse/ville"/> <br/>
                        <xsl:value-of select="adresse/codePostal"/>
                    </div>

                    <div class="header">Dernière Visite :</div>
                    <div class="visit">
                        <div class="header">Date :</div>
                        <div class="value"><xsl:value-of select="visites/visite/date"/></div>

                        <div class="header">Acte :</div>
                        <div class="value"><xsl:value-of select="visites/visite/acte"/></div>

                        <div class="header">Infirmier :</div>
                        <div class="value"><xsl:value-of select="visites/visite/infirmier"/></div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
