<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:ca="http://www.univ-grenoble-alpes.fr/l3miage/medical/cabinet">
	<xsl:output method="html" encoding="UTF-8" indent="yes" />

	<xsl:param name="destinedId" select="'002'" />

	<xsl:template match="/">
		<html lang="fr">
			<head>
				<title>Planning des Soins - Cabinet Médical</title>
				<style>
					body {
					font-family: 'Segoe UI', Arial, sans-serif;
					background-color: #E3F2FD;
					margin: 0;
					color: #333;
					}
					.header {
					background-color: #0D47A1;
					color: #ffffff;
					text-align: center;
					padding: 20px;
					font-size: 24px;
					font-weight: bold;
					}
					.container {
					background: #ffffff;
					border-radius: 10px;
					box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
					margin: 30px auto;
					padding: 25px;
					max-width: 900px;
					}
					.patient-info {
					background-color: #E3F2FD;
					padding: 15px;
					margin-bottom: 20px;
					border-radius: 8px;
					box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
					}
					.section-title {
					font-size: 20px;
					color: #0D47A1;
					font-weight: bold;
					margin-bottom: 10px;
					}
					.info-row {
					display: flex;
					justify-content: space-between;
					padding: 5px 0;
					}
					.info-label {
					font-weight: bold;
					color: #0D47A1;
					}
					.highlight {
					font-weight: bold;
					color: #0D47A1;
					}
				</style>
			</head>
			<body>
				<!-- Titre principal -->
				<div class="header">
					Planning des Soins
				</div>

				<!-- Conteneur principal -->
				<div class="container">
					<p><strong>Bonjour <xsl:value-of select="//ca:infirmier[@id=$destinedId]/ca:prenom" />,</strong></p>
					<p>Vous avez les patients suivants pour aujourd'hui :</p>

					<!-- Liste des patients associés à l'infirmier -->
					<xsl:for-each select="//ca:patients/ca:patient">
						<xsl:if test="ca:visite/ca:intervenant[@id=$destinedId]">
							<div class="patient-info">
								<div class="section-title">Détails du Patient</div>
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

								<!-- Détails des visites -->
								<xsl:for-each select="ca:visite">
									<xsl:if test="ca:intervenant/@id=$destinedId">
										<div class="section-title">Visite</div>
										<div class="info-row">
											<span class="info-label">Date :</span>
											<span class="highlight"><xsl:value-of select="ca:date" /></span>
										</div>
										<div class="info-row">
											<span class="info-label">Acte médical :</span>
											<span class="highlight">
												<xsl:value-of select="//ca:acte/ca:actes/ca:acte[@id=current()/@acte]" />
											</span>
										</div>
									</xsl:if>
								</xsl:for-each>
							</div>
						</xsl:if>
					</xsl:for-each>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
