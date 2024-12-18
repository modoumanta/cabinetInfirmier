<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:ca="http://www.univ-grenoble-alpes.fr/l3miage/medical/cabinet">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

	<xsl:param name="filterName" select="''" />

	<xsl:template match="/">
		<html lang="fr">
			<head>
				<title>Fiche Patients</title>
				<!-- Inclure le script JavaScript -->
				<script type="text/javascript" src="../js/facture.js"></script>
				<style>
					body {
					font-family: 'Segoe UI', Arial, sans-serif;
					background-color: #E3F2FD;
					margin: 0;
					color: #333;
					}
					.container {
					background: #ffffff;
					border-radius: 12px;
					box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
					margin: 40px auto;
					padding: 30px;
					max-width: 800px;
					}
					h1 {
					color: #0D47A1;
					text-align: center;
					font-size: 28px;
					margin-bottom: 30px;
					border-bottom: 2px solid #BBDEFB;
					padding-bottom: 10px;
					}
					.info-row {
					display: flex;
					justify-content: space-between;
					padding: 8px 0;
					}
					.info-label {
					color: #0D47A1;
					font-weight: bold;
					}
					.visite {
					background-color: #E3F2FD;
					padding: 15px;
					border-radius: 8px;
					margin: 15px 0;
					}
					button {
					background-color: #0D47A1;
					color: white;
					border: none;
					padding: 8px 12px;
					border-radius: 5px;
					cursor: pointer;
					font-size: 14px;
					}
					button:hover {
					background-color: #1976D2;
					}
				</style>
			</head>
			<body>
				<div class="container">
					<h1>Fiche Patient</h1>
					<!-- Parcourir les patients -->
					<xsl:for-each select="//ca:patient">
						<xsl:if test="$filterName='' or ca:nom=$filterName">
							<div class="info-row">
								<span class="info-label">Nom :</span>
								<span class="highlight"><xsl:value-of select="ca:nom" /></span>
							</div>
							<div class="info-row">
								<span class="info-label">Prénom :</span>
								<span class="highlight"><xsl:value-of select="ca:prenom" /></span>
							</div>
							<div class="info-row">
								<span class="info-label">Date de naissance :</span>
								<span><xsl:value-of select="ca:naissance" /></span>
							</div>
							<div class="info-row">
								<span class="info-label">Adresse :</span>
								<span>
									<xsl:value-of select="concat(ca:adresse/ca:numero, ' ', ca:adresse/ca:rue, ', ', ca:adresse/ca:codePostal, ', ', ca:adresse/ca:ville)" />
								</span>
							</div>

							<!-- Affichage des visites -->
							<div class="section-title">Visites :</div>
							<xsl:for-each select="ca:visite">
								<div class="visite">
									<div class="info-row">
										<span class="info-label">Date :</span>
										<span class="highlight"><xsl:value-of select="ca:date" /></span>
									</div>

									<!-- Récupération des informations de l'intervenant -->
									<xsl:variable name="intervenantID" select="ca:intervenant/@id" />
									<xsl:variable name="intervenant" select="//ca:infirmier[@id=$intervenantID]" />
									<div class="info-row">
										<span class="info-label">Intervenant :</span>
										<span>
											<xsl:value-of select="concat($intervenant/ca:prenom, ' ', $intervenant/ca:nom, ' (ID: ', $intervenantID, ')')" />
										</span>
									</div>

									<!-- Récupération de l'acte médical -->
									<xsl:variable name="acteID" select="@acte" />
									<xsl:variable name="acte" select="//ca:acte/ca:actes/ca:acte[@id=$acteID]" />
									<div class="info-row">
										<span class="info-label">Acte médical :</span>
										<span class="highlight">
											<xsl:value-of select="$acte" />
										</span>
									</div>

									<!-- Bouton Facture -->
									<button>
										<xsl:attribute name="onclick">
											<xsl:text>openFacture('</xsl:text>
											<xsl:value-of select="translate(normalize-space(ca:prenom), &quot;'&quot;, &quot;\&apos;&quot;)" />
											<xsl:text>', '</xsl:text>
											<xsl:value-of select="translate(normalize-space(ca:nom), &quot;'&quot;, &quot;\&apos;&quot;)" />
											<xsl:text>', '</xsl:text>
											<xsl:value-of select="translate(normalize-space($acte), &quot;'&quot;, &quot;\&apos;&quot;)" />
											<xsl:text>')</xsl:text>
										</xsl:attribute>
										Facture
									</button>
								</div>
							</xsl:for-each>
						</xsl:if>
					</xsl:for-each>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
