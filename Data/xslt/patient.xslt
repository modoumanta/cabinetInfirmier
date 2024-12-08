<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
				xmlns:ca="http://www.univ-grenoble-alpes.fr/l3miage/medical/cabinet"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				exclude-result-prefixes="xsl">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

	<!-- Paramètre facultatif pour filtrer un patient spécifique -->
	<xsl:param name="filterName" select="''" />

	<xsl:template match="/">
		<html lang="fr">
			<head>
				<title>Liste des Patients</title>
				<style>
					body { font-family: Arial, sans-serif; }
					h1 { color: #004080; }
					.patient { margin-bottom: 30px; border: 1px solid #ccc; padding: 10px; }
					.visite { margin-left: 20px; }
				</style>
	</head>
		<body>
			<h1>Fiche Patients</h1>

			<!-- Parcourir tous les patients -->
				<xsl:for-each select="//ca:patient">
					<!-- Filtrer par nom si un filtre est défini -->
					<xsl:if test="$filterName='' or ca:nom=$filterName">
						<div class="patient">
					<h2>Patient : <xsl:value-of select="ca:prenom" /> <xsl:value-of select="ca:nom" /></h2>
					<p><strong>Sexe :</strong> <xsl:value-of select="ca:sexe" /></p>
					<p><strong>Date de naissance :</strong> <xsl:value-of select="ca:naissance" /></p>
					<p><strong>Numéro de Sécurité Sociale :</strong> <xsl:value-of select="ca:numeroSecu" /></p>
					<p><strong>Adresse :</strong></p>
					<ul>
						<li><xsl:value-of select="ca:adresse/ca:numero" /> <xsl:value-of select="ca:adresse/ca:rue" /></li>
						<li><xsl:value-of select="ca:adresse/ca:codePostal" /> <xsl:value-of select="ca:adresse/ca:ville" /></li>
						<li>Étage : <xsl:value-of select="ca:adresse/ca:etage" /></li>
						</ul>
						<h3>Visites :</h3>
						<xsl:for-each select="ca:visite">
							<div class="visite">
								<p><strong>Date :</strong> <xsl:value-of select="ca:date" /></p>
								<p><strong>ID de l'Intervenant :</strong> <xsl:value-of select="ca:intervenant/@id" /></p>
								<p><strong>Acte :</strong>
									<xsl:choose>
										<xsl:when test="@acte='103'">Prélèvement aseptique</xsl:when>
										<xsl:when test="@acte='102'">Saignée</xsl:when>
										<xsl:when test="@acte='101'">Prélèvement par ponction</xsl:when>
										<xsl:otherwise>Acte inconnu</xsl:otherwise>
									</xsl:choose>
								</p>
							</div>
						</xsl:for-each>
					</div>
				</xsl:if>
			</xsl:for-each>
		</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
