<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="tpl.template.xsl" />

	<xsl:template name="title">
		<xsl:value-of select="'Resihop - Samåkning '" />
		<xsl:if test="/root/meta/url_params/q and not(/root/meta/url_params/q = '')" >
			<xsl:value-of select="' till eller från '" />
			<xsl:value-of select="/root/meta/url_params/q" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/from and not(/root/meta/url_params/from = '')" >
			<xsl:value-of select="' från '" />
				<xsl:if test="substring(from,string-length(from) - 7,8) = ', Sweden'">
					<xsl:value-of select="substring(from, 0, string-length(from) - 7)" />
				</xsl:if>
				<xsl:if test="substring(from,string-length(from) - 7,8) != ', Sweden'">
					<xsl:value-of select="from"/>
				</xsl:if>
		</xsl:if>
		<xsl:if test="/root/meta/url_params/to and not(/root/meta/url_params/to = '')" >
			<xsl:value-of select="' till '" />
			<xsl:if test="substring(to,string-length(to) - 7,8) = ', Sweden'">
				<xsl:value-of select="substring(to, 0, string-length(to) - 7)" />
			</xsl:if>
			<xsl:if test="substring(to,string-length(to) - 7,8) != ', Sweden'">
				<xsl:value-of select="to"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="/root/meta/url_params/when and not(/root/meta/url_params/when = '')" >
			<xsl:value-of select="' den '" />
			<xsl:value-of select="/root/meta/url_params/when" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/got_car = '1'" >
			<xsl:value-of select="' med bil.'" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/got_car = '0'" >
			<xsl:value-of select="' som söker bil.'" />
		</xsl:if>
	</xsl:template>
	<xsl:template name="goal">
		<xsl:choose>
			<xsl:when test="count(/root/content/trips/trip) = 0 and not(/root/meta/errors)">
				<xsl:text>_gaq.push(['_trackPageview', '/added_trip/try/force']);</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>_gaq.push(['_trackPageview', '/search/done']);</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="description">
		<xsl:value-of select="'Alla våra resor'" />
		<xsl:if test="/root/meta/url_params/q and not(/root/meta/url_params/q = '')" >
			<xsl:value-of select="' till eller från '" />
			<xsl:value-of select="/root/meta/url_params/q" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/from and not(/root/meta/url_params/from = '')" >
			<xsl:value-of select="' från '" />
			<xsl:value-of select="/root/meta/url_params/from" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/to and not(/root/meta/url_params/to = '')" >
			<xsl:value-of select="' till '" />
			<xsl:value-of select="/root/meta/url_params/to" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/when and not(/root/meta/url_params/when = '')" >
			<xsl:value-of select="' den '" />
			<xsl:value-of select="/root/meta/url_params/when" />
		</xsl:if>
	</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<xsl:template match="/root/content">
		<xsl:choose>

			<!-- Inga träffar så vi visar spara resa istället -->
			<xsl:when test="count(/root/content/trips/trip) = 0 and not(/root/meta/errors)">
				<xsl:choose>
					<xsl:when test="/root/meta/url_params/got_car = 0">
						<xsl:call-template name="trip_form">
							<xsl:with-param name="header"   select="'Ingen resa matchade din sökning - Spara din resa'" />
							<xsl:with-param name="size"     select="'savetrip'" />
							<xsl:with-param name="function" select="'addtrip'" />
	
							<!-- Since you search for got_car 0, you're a driver -->
							<xsl:with-param name="type" select="'driver'" />
	
						</xsl:call-template>
					</xsl:when>
	
					<xsl:when test="/root/meta/url_params/got_car = 1">
						<xsl:call-template name="trip_form">
							<xsl:with-param name="header"   select="'Ingen resa matchade din sökning - Spara din resa'" />
							<xsl:with-param name="size"     select="'savetrip'" />
							<xsl:with-param name="function" select="'addtrip'" />
	
							<!-- Since you search for got_car 1, you're a passenger -->
							<xsl:with-param name="type" select="'passenger'" />
	
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="trip_form">
							<xsl:with-param name="type" select="''" />
							<xsl:with-param name="header" select="'Spara din resa'" />
							<xsl:with-param name="function" select="'addtrip'" />
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:when>

			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="/root/meta/url_params/got_car = 0">
						<xsl:call-template name="message">
							<xsl:with-param name="type" select="'driver'" />
						</xsl:call-template>
	
						<xsl:call-template name="logo">
							<xsl:with-param name="type" select="'driver'" />
						</xsl:call-template>
	
						<xsl:call-template name="trip_form">
							<xsl:with-param name="header" select="'Jag söker passagerare'" />
							<xsl:with-param name="type" select="'driver'" />
							<xsl:with-param name="size" select="'search'" />
							<xsl:with-param name="function" select="'search'" />
						</xsl:call-template>
	
						<xsl:call-template name="searchresults">
							<xsl:with-param name="type" select="'driver'" />
						</xsl:call-template>
					</xsl:when>
	
					<xsl:when test="/root/meta/url_params/got_car = 1">
						<xsl:call-template name="trip_form">
							<xsl:with-param name="header" select="'Jag söker skjuts'" />
							<xsl:with-param name="type" select="'passenger'" />
							<xsl:with-param name="size" select="'search'" />
							<xsl:with-param name="function" select="'search'" />
						</xsl:call-template>
	
						<xsl:call-template name="logo">
							<xsl:with-param name="type" select="'passenger'" />
						</xsl:call-template>
	
						<xsl:call-template name="message">
							<xsl:with-param name="type" select="'passenger'" />
						</xsl:call-template>
	
						<xsl:call-template name="searchresults">
							<xsl:with-param name="type" select="'passenger'" />
						</xsl:call-template>
					</xsl:when>
	
					<xsl:otherwise>
						<xsl:call-template name="trip_form">
							<xsl:with-param name="header" select="'Specificera din sökning'" />
							<xsl:with-param name="size" select="'search'" />
							<xsl:with-param name="function" select="'search'" />
							<xsl:with-param name="type" select="''" />
						</xsl:call-template>
	
						<xsl:call-template name="logo">
							<xsl:with-param name="type" select="''" />
						</xsl:call-template>
	
						<xsl:call-template name="message">
							<xsl:with-param name="type" select="''" />
						</xsl:call-template>
	
						<xsl:call-template name="searchresults">
							<xsl:with-param name="type" select="''" />
						</xsl:call-template>
	
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>

		</xsl:choose>

	</xsl:template>


</xsl:stylesheet>
