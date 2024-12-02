<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:ca="http://www.univ-grenoble-alpes.fr/l3miage/medical/cabinet">
	<xsl:output method="html"/>
	
	<xsl:variable name="monprog">Ahmadou gueye</xsl:variable>
	<xsl:variable name="date">2024-09-25</xsl:variable>
	<xsl:param name="destinedId" select="002" />
	<!--<xsl:variable name="actes" select="document(’cabinet.xml’, /)/act:ngap"/>-->
	
	<xsl:template match="/">
		<xsl:param name="cpt" select="0"  />
		<xsl:variable name="infirmiere" select="//ca:cabinet/ca:infirmiers/ca:infirmier[@id=$destinedId]" />
		<xsl:variable name="patient" select="//ca:cabinet/ca:patients/ca:patient" />
		<xsl:variable name="patients" select="//ca:cabinet/ca:patients" />
		<xsl:variable name="nom" select="$infirmiere/ca:prenom" />
		<xsl:variable name="nombrePatientsPourlInfirmier" select="count($patient/ca:visite/ca:intervenant[@id=$destinedId])" />
		
		<!-- Page d'accueil -->
		<html lang="fr">
			<head>
				<title>Cabinet Médical</title>
				<style>
					/* Ajouter un style de base pour la mise en forme */
					body { font-family: Arial, sans-serif; }
					h1 { color: #004080; }
					ul { list-style-type: none; padding: 0; }
					li { margin: 5px 0; }
					.menu { background-color: #cce6ff; padding: 10px; }
					.menu a { text-decoration: none; color: #004080; font-weight: bold; }
				</style>
			</head>
			<body>
				<h1>Bonjour <xsl:value-of select="$nom" />,</h1>
				<p>Aujourd'hui, vous avez <xsl:value-of select="$nombrePatientsPourlInfirmier" /> patients.</p>
				
				<xsl:for-each select="$patient">
					<xsl:if test="ca:visite/ca:intervenant/@id=$destinedId">
						
						<p><xsl:value-of select="$cpt+1"/> patient:</p><br/>
						
						<p>Nom: <xsl:value-of select="ca:nom" /></p>
						
						<p>Prenom: <xsl:value-of select="ca:prenom" /></p>
						
						<p><xsl:value-of select="ca:prenom" /> est nee le <xsl:value-of select="ca:naissance" /></p>
						
						<p>Adresse: <xsl:value-of select="ca:adresse" /></p>
							
						<xsl:if test="//ca:cabinet/ca:acte/ca:actes/ca:acte/@id=ca:visite/@acte">
								<p>Visite: la visite devra avoir lieu le <xsl:value-of select="ca:visite/@date" /> pour <xsl:value-of select="//ca:cabinet/ca:acte/ca:actes/ca:acte" /></p>
						</xsl:if>
						
						<xsl:for-each select="/ca:visite">
						</xsl:for-each>
					</xsl:if>
					<xsl:with-param name="cpt" select="$cpt + 1" />
				</xsl:for-each>
				<!-- Titre et informations du cabinet -->
				
			
			</body>
		</html>
	</xsl:template>


</xsl:stylesheet>