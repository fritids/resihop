<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="tpl.template.xsl" />

	<xsl:template name="title">Ett miljövänligt och billigt sätt att resa - Samåkning</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<xsl:template match="/root/content">
		<xsl:call-template name="trip_form">
			<xsl:with-param name="header" select="'Jag söker skjuts'" />
			<xsl:with-param name="type" select="'driver'" />
		</xsl:call-template>
		<xsl:call-template name="trip_form">
			<xsl:with-param name="header" select="'Jag söker passagerare'" />
			<xsl:with-param name="type" select="'passenger'" />
		</xsl:call-template>
		<xsl:call-template name="logo" />
	</xsl:template>

</xsl:stylesheet>