<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output
		method="html"
		encoding="utf-8"
		doctype-system="about:legacy-compat"
		indent="no"
		omit-xml-declaration="no"
	/>

	<xsl:template name="base">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="sv" lang="sv">
			<head>
				<meta charset="UTF-8" />
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<link type="text/css" rel="stylesheet" media="all">
					<xsl:attribute name="href">
						<xsl:text>/css/style-</xsl:text>
						<xsl:value-of select="/root/meta/version" />
						<xsl:text>.css</xsl:text>
					</xsl:attribute>
				</link>
				<base href="http://{root/meta/domain}/" />
				<link rel="icon" type="image/png" href="/favicon.png" />
				<link rel="search" type="application/opensearchdescription+xml" href="quicksearch.xml" title="Resihop.nu" />
				<title><xsl:call-template name="title" /></title>
				<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"><![CDATA[ // ]]></script>
				<script type="text/javascript" src="/js/jquery-1.4.2.min.js"><![CDATA[ // ]]></script>
				<script type="text/javascript" src="/js/ui.geo_autocomplete.js"><![CDATA[ // ]]></script>
				<script type="text/javascript" src="/js/common-2.0.js"><![CDATA[ // ]]></script>
				<script type="text/javascript">
					var _gaq = _gaq || [];
					_gaq.push(['_setAccount', 'UA-6975218-3']);
					_gaq.push(['_trackPageview']);

					(function() {
						var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
						ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
						var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
					})();
				</script>
			</head>
			<body>
				<div id="wrapper">
					<xsl:choose>
						<xsl:when test="/root/meta/controller = 'search'">
							<xsl:if test="/root/meta/url_params/got_car = 1">
								<xsl:attribute name="class">driver</xsl:attribute>
							</xsl:if>
							<xsl:if test="/root/meta/url_params/got_car = 0">
								<xsl:attribute name="class">passenger</xsl:attribute>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="/root/meta/url_params/got_car = 1">
								<xsl:attribute name="class">passenger</xsl:attribute>
							</xsl:if>
							<xsl:if test="/root/meta/url_params/got_car = 0">
								<xsl:attribute name="class">driver</xsl:attribute>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
					<div id="header">
						<a class="header" href="/"><h1>resihop</h1></a>
						<ul id="menu">
							<li><a href="/edittrip">Ändra/Ta bort resa</a></li>
							<li><a>
								<xsl:attribute name="href">
									<xsl:text>/addtrip?from=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/from" />
									<xsl:text>&amp;to=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/to" />
									<xsl:text>&amp;name=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/name" />
									<xsl:text>&amp;email=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/email" />
									<xsl:text>&amp;phone=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/phone" />
									<xsl:text>&amp;details=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/details" />
								</xsl:attribute>
								Lägg till resa
								</a></li>
								<li><a href="/">Sök resa</a></li>
						</ul>
						<p class="catchphrase">Samåkning är ett miljövänligt och billigt sätt att resa.</p>
					</div>
					<xsl:apply-templates select="/root/content" />
				</div>
				<div id="footer">
					<ul>
						<li><a href="/about/">Om resihop</a></li>
						<li><a href="/api/">Api</a></li>
						<li><a href="/contact/">Kontakt</a></li>
					</ul>
					<a id="legal" href="http://kopimi.com">Kopimi</a>
				</div>
				<script type="text/javascript">
						var _kundo = _kundo || {};
						_kundo["org"] = "resihop";

						(function() {
								function async_load(){
										var s = document.createElement('script');
										s.type = 'text/javascript';
										s.async = true;
										s.src = ('https:' == document.location.protocol ? 'https://' : 'http://') +
										'static.kundo.se/embed.js';
										var x = document.getElementsByTagName('script')[0];
										x.parentNode.insertBefore(s, x);
								}
								if (window.attachEvent)
										window.attachEvent('onload', async_load);
								else
										window.addEventListener('load', async_load, false);
						})();
				</script>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="trip_form">
		<xsl:param name="type" />
		<xsl:param name="size" />
		<xsl:param name="header" />
		<xsl:param name="function" />

		<xsl:variable name="newtype">
			<xsl:if test="/root/content/trip_data/got_car = 0">
				<xsl:value-of select="'passenger'" />
			</xsl:if>
			<xsl:if test="$type != ''">
				<xsl:value-of select="$type" />
			</xsl:if>
		</xsl:variable>

		<form class="trip" method="get">
			<xsl:attribute name="action">
				<xsl:choose>
					<xsl:when test="$function != ''">
						<xsl:value-of select="'/'" />
						<xsl:value-of select="$function" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'/search'" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<fieldset>
				<xsl:attribute name="class">
					<xsl:value-of select="$newtype" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="$size" />
				</xsl:attribute>
				<h2>
				<xsl:choose>
					<xsl:when test='$header'>
						<xsl:value-of select="$header" />
					</xsl:when>
					<xsl:when test="$size = '' and /root/meta/url_params/got_car = 0">Jag söker passagerare</xsl:when>
					<xsl:when test="$size = '' and /root/meta/url_params/got_car = 1">Jag söker skjuts</xsl:when>
					<xsl:otherwise>Specificera din sökning</xsl:otherwise>
				</xsl:choose>
				</h2>
				<xsl:if test="$size = 'savetrip'">
					<p class="regular">
						<xsl:choose>
								<xsl:when test="/root/meta/controller = 'addtrip'">
									För att andra ska kunna kontakta dig behöver vi lite mer information.
								</xsl:when>
								<xsl:when test="/root/meta/controller = 'edittrip' and not(/root/meta/url_params/posted)">
									Ändra de uppgifter du vill. Låt de andra vara som de är.
								</xsl:when>
								<xsl:when test="/root/meta/controller = 'edittrip' and /root/meta/url_params/posted">
									Dina uppgifter är nu ändrade!
								</xsl:when>
								<xsl:otherwise>
									Vi hittade <em>inga
									<xsl:if test="/root/meta/url_params/got_car = '0'">
										passagerare
									</xsl:if>
									<xsl:if test="/root/meta/url_params/got_car = '1'">
										bilar
									</xsl:if>
									</em> för din sökning. Ange dina kontaktuppgifter så att andra kan <em>hitta dig</em>.
								</xsl:otherwise>
						</xsl:choose>
					</p>
				</xsl:if>
				<xsl:if test="$size = 'savetrip'">
					<input type="hidden" name="posted" value="" />
				</xsl:if>
				<div class="generals">
					<xsl:call-template name="inputfield">
						<xsl:with-param name="inputid" select="'from'" />
						<xsl:with-param name="inputlabel" select="'Från'" />
						<xsl:with-param name="inputtitle" select="'Ort, gata eller kommun'" />
						<xsl:with-param name="value" select="/root/meta/url_params/from" />
					</xsl:call-template>
					<xsl:call-template name="inputfield">
						<xsl:with-param name="inputid" select="'to'" />
						<xsl:with-param name="inputlabel" select="'Till'" />
						<xsl:with-param name="inputtitle" select="'Ort, gata eller kommun'" />
						<xsl:with-param name="value" select="/root/meta/url_params/to" />
					</xsl:call-template>
					<xsl:call-template name="inputfield">
						<xsl:with-param name="inputid" select="'when'" />
						<xsl:with-param name="inputlabel" select="'När'" />
						<xsl:with-param name="inputtitle" select="'YYYY-MM-DD'" />
						<xsl:with-param name="value" select="/root/meta/url_params/when" />
					</xsl:call-template>
				</div>
				<xsl:if test="$size = 'savetrip'">
					<div id="contact">
		 				<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'name'" />
							<xsl:with-param name="inputlabel" select="'Namn'" />
						</xsl:call-template>
						<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'email'" />
							<xsl:with-param name="inputlabel" select="'E-post'" />
						</xsl:call-template>
						<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'phone'" />
							<xsl:with-param name="inputlabel" select="'Telefon'" />
						</xsl:call-template>
					</div>
					<div id="details">
						<label class="regular" for="details">Detaljer</label>
						<textarea id="details" name="details" class="field" rows="4" cols="10">
							<xsl:choose>
								<xsl:when test="(/root/meta/url_params/details = '' or not(/root/meta/url_params/details)) and not(/root/content/trip_data/details)">
									<xsl:value-of select="' '" />
								</xsl:when>
								<xsl:when test="not(/root/meta/url_params/details) or /root/meta/url_params/details = ''">
									<xsl:value-of select="/root/content/trip_data/details" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/root/meta/url_params/details" />
								</xsl:otherwise>
							</xsl:choose>
						</textarea>
					</div>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="/root/meta/path = 'edittrip' or ((/root/meta/url_params/got_car ='' or not(/root/meta/url_params/got_car)) and /root/meta/controller != 'welcome')">
						<div id="radiobuttons">
							<xsl:choose>
								<xsl:when test =" $size = ''">
									<input id="car" type="radio" value="1" name="got_car">
										<xsl:if test="/root/meta/url_params/got_car = 1">
											<xsl:attribute name="checked">
												checked
											</xsl:attribute>
										</xsl:if>
										<xsl:if test="not(/root/meta/url_params/got_car) and /root/content/trip_data/got_car = 1">
											<xsl:attribute name="checked">
												checked
											</xsl:attribute>
										</xsl:if>
									</input>
									<xsl:if test="/root/meta/controller = 'search'">
										<label class="regular" for="car">Jag söker skjuts</label>
									</xsl:if>
									<xsl:if test="not(/root/meta/controller = 'search')">
										<label class="regular" for="car">Jag söker passagerare</label>
									</xsl:if>
									<input id="passenger" type="radio" value="0" name="got_car">
										<xsl:if test="/root/meta/url_params/got_car = 0">
											<xsl:attribute name="checked">
												checked
											</xsl:attribute>
										</xsl:if>
										<xsl:if test="not(/root/meta/url_params/got_car) and /root/content/trip_data/got_car = 0">
											<xsl:attribute name="checked">
												checked
											</xsl:attribute>
										</xsl:if>
									</input>
									<xsl:if test="/root/meta/controller = 'search'">
										<label class="regular" for="passenger">Jag söker passagerare</label>
									</xsl:if>
									<xsl:if test="not(/root/meta/controller = 'search')">
										<label class="regular" for="passenger">Jag söker skjuts</label>
									</xsl:if>
								</xsl:when>

								<xsl:when test =" $size = 'savetrip'">
									<input id="car" type="radio" value="1" name="got_car">
										<xsl:if test="/root/meta/url_params/got_car = 0">
											<xsl:attribute name="checked">
												checked
											</xsl:attribute>
										</xsl:if>
										<xsl:if test="not(/root/meta/url_params/got_car) and /root/content/trip_data/got_car = 0">
											<xsl:attribute name="checked">
												checked
											</xsl:attribute>
										</xsl:if>
									</input>
										<label class="regular" for="car">Jag söker skjuts</label>
										<input id="passenger" type="radio" value="0" name="got_car">
											<xsl:if test="/root/meta/url_params/got_car = 1">
												<xsl:attribute name="checked">
													checked
												</xsl:attribute>
											</xsl:if>
											<xsl:if test="not(/root/meta/url_params/got_car) and /root/content/trip_data/got_car = 1">
												<xsl:attribute name="checked">
													checked
												</xsl:attribute>
											</xsl:if>
									</input>
									<label class="regular" for="passenger">Jag söker passagerare</label>
								</xsl:when>
							</xsl:choose>
						</div>
						<input type="hidden" name="code">
							<xsl:attribute name="value">
								<xsl:value-of select="/root/meta/url_params/code" />
							</xsl:attribute>
						</input>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="got_car">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="/root/meta/url_params/got_car and not($size = 'savetrip')" >
										<xsl:value-of select="/root/meta/url_params/got_car" />
									</xsl:when>
									<xsl:when test="/root/meta/url_params/got_car and $size = 'savetrip'" >
										<xsl:if test="/root/meta/url_params/got_car = 0">
											<xsl:value-of select="1" />
										</xsl:if>
										<xsl:if test="/root/meta/url_params/got_car = 1">
											<xsl:value-of select="0" />
										</xsl:if>
									</xsl:when>
									<xsl:when test="not(/root/meta/url_params/got_car) and $newtype='passenger'">
										<xsl:value-of select="'0'" />
									</xsl:when>
									<xsl:otherwise>
											<xsl:value-of select="'1'" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</xsl:otherwise>
				</xsl:choose>
				<input class="button" type="submit">
					<xsl:attribute name="value">
					<xsl:choose>
						<xsl:when test="$function = 'addtrip'">
							<xsl:value-of select="'Spara resa'" />
						</xsl:when>
						<xsl:when test="$function = 'edittrip'">
							<xsl:value-of select="'Ändra resa'" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'Sök'" />
						</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
				</input>
				<xsl:if test="/root/meta/path = 'edittrip'">
					<a class="button">
					<xsl:attribute name="href">
						<xsl:text>/edittrip?remove&amp;code=</xsl:text>
						<xsl:value-of select="/root/meta/url_params/code" />
					</xsl:attribute>
					Ta bort resa</a>
				</xsl:if>

			</fieldset>
		</form>
	</xsl:template>

	<xsl:template name="trip_saved">
		<xsl:param name="header" />
		<div class="savetrip">
			<h2>
				<xsl:value-of select="$header" />
			</h2>
			<div class="saved_trip">
				<p class="regular">Koden nedan kan användas om du vill ändra på din resa framöver, du kan också få den mailad till dig senare.</p>
				<p class="code">
					<xsl:value-of select="/root/content/new_trip/code" />
				</p>
					<p class="prebutton">Lägg till
						<a class="button">
							<xsl:attribute name="href">
								<xsl:text>http://</xsl:text>
								<xsl:value-of select="/root/meta/domain" />
								<xsl:text>/addtrip?from=</xsl:text>
								<xsl:value-of select="/root/content/new_trip/to" />
								<xsl:text>&amp;to=</xsl:text>
								<xsl:value-of select="/root/content/new_trip/from" />
								<xsl:text>&amp;name=</xsl:text>
								<xsl:value-of select="/root/content/new_trip/name" />
								<xsl:text>&amp;email=</xsl:text>
								<xsl:value-of select="/root/content/new_trip/email" />
								<xsl:text>&amp;phone=</xsl:text>
								<xsl:value-of select="/root/content/new_trip/phone" />
								<xsl:text>&amp;details=</xsl:text>
								<xsl:value-of select="/root/content/new_trip/details" />
							</xsl:attribute>
							Returresa
						</a>
					</p>
			</div>
			<table>
				<tr>
					<td class="label">
					</td>
					<td class="edit">
						<a>
							<xsl:attribute name="href">
								<xsl:text>http://</xsl:text>
								<xsl:value-of select="/root/meta/domain" />
								<xsl:text>/edittrip?code=</xsl:text>
								<xsl:value-of select="/root/content/new_trip/code" />
							</xsl:attribute>
							Ändra
						</a>
					</td>
				</tr>
				<tr>
					<td class="label">
						Från
					</td>
					<td>
						<xsl:value-of select="/root/content/new_trip/from" />
					</td>
				</tr>
				<tr>
					<td class="label">
						Till
					</td>
					<td>
						<xsl:value-of select="/root/content/new_trip/to" />
					</td>
				</tr>
				<tr>
					<td class="label">
						När
					</td>
					<td>
						<xsl:value-of select="/root/content/new_trip/when_iso" />
					</td>
				</tr>
				<tr>
					<td class="label">
						Namn
					</td>
					<td>
						<xsl:value-of select="/root/content/new_trip/name" />
					</td>
				</tr>
				<tr>
					<td class="label">
						E-post
					</td>
					<td>
						<xsl:value-of select="/root/content/new_trip/email" />
					</td>
				</tr>
				<tr>
					<td class="label">
						Telefon
					</td>
					<td>
						<xsl:value-of select="/root/content/new_trip/phone" />
					</td>
				</tr>
				<tr>
					<td class="label last">
						Detaljer
					</td>

					<td class="last" >
						<xsl:value-of select="/root/content/new_trip/details" />
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="inputfield">
		<xsl:param name="inputid" />
		<xsl:param name="inputlabel" />
		<xsl:param name="inputtitle" />
		<xsl:param name="value" />

		<label class="regular" for="name">
			<xsl:attribute name="for">
				<xsl:value-of select="$inputid" />
			</xsl:attribute>
			<xsl:value-of select="$inputlabel" />
		</label>

		<input type="text">
			<xsl:attribute name="class">
				<xsl:value-of select="'field'" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="$inputid" />
			</xsl:attribute>
			<xsl:attribute name="id">
				<xsl:value-of select="$inputid" />
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="$inputid" />
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:value-of select="$inputtitle" />
			</xsl:attribute>
			<xsl:attribute name="value">
				<xsl:value-of select="/root/meta/url_params/*[name()=$inputid]"/>
				<xsl:if test="not(/root/meta/url_params/*[name()=$inputid])">
					<xsl:choose>
						<xsl:when test="$inputid = 'when'">
							<xsl:value-of select="/root/content/trip_data/when_iso" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/root/content/trip_data/*[name()=$inputid]" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:attribute>
		</input>

		<xsl:if test="/root/meta/errors/error/data/param = $inputid">
			<xsl:for-each select="/root/meta/url_params/*">
				<xsl:if test="name(.) = $inputid and(. !='' or /root/meta/url_params/posted) ">
					<div>
						<xsl:attribute name="class">
							<xsl:value-of select="'spacer'" />
						</xsl:attribute>
						<label>
							<xsl:attribute name="for">
								<xsl:value-of select="name(.)" />
							</xsl:attribute>
							<xsl:attribute name="class">
								<xsl:value-of select="'error '" />
								<xsl:value-of select="name(.)" />
								<!-- lägger till visible på det första felmeddelandet -->
								<xsl:if test="name(.) = 'code'">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="name(.) = 'from'">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'to' and
										not(/root/meta/errors/error/data/param = 'from')
									">
									<xsl:value-of select="' visible '" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'when' and
										not(/root/meta/errors/error/data/param = 'from') and
										not(/root/meta/errors/error/data/param = 'to')
									">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'name' and
										not(/root/meta/errors/error/data/param = 'from') and
										not(/root/meta/errors/error/data/param = 'to') and
										not(/root/meta/errors/error/data/param = 'when')
									">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'email' and
										not(/root/meta/errors/error/data/param = 'from') and
										not(/root/meta/errors/error/data/param = 'to') and
										not(/root/meta/errors/error/data/param = 'when') and
										not(/root/meta/errors/error/data/param = 'name')
									">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'phone' and
										not(/root/meta/errors/error/data/param = 'from') and
										not(/root/meta/errors/error/data/param = 'to') and
										not(/root/meta/errors/error/data/param = 'when') and
										not(/root/meta/errors/error/data/param = 'name') and
										not(/root/meta/errors/error/data/param = 'email')
									">
									<xsl:value-of select="' visible'" />
								</xsl:if>
							</xsl:attribute>

							<xsl:choose>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Required'">
									<xsl:choose>
										<xsl:when test="$inputid = 'from'">
											<p>Var åker du ifrån?</p>
										</xsl:when>
										<xsl:when test="$inputid = 'to'">
											<p>Var ska du?</p>
										</xsl:when>
										<xsl:when test="$inputid = 'when'">
											<p>När vill du åka?</p>
										</xsl:when>
										<xsl:when test="$inputid = 'name'">
											<p>Ge oss ett namn. Det behöver inte vara ditt riktiga, get creative!</p>
										</xsl:when>
										<xsl:when test="$inputid = 'email'">
											<p>Ange en e-post-adress. Skriv en riktig, du kan lite på oss :)</p>
										</xsl:when>
										<xsl:when test="$inputid = 'phone'">
											<p>Ge oss ett telefonnummer, så folk kan få tag på dig.</p>
										</xsl:when>
										<xsl:otherwise>
											<p>Skriv något i den här här rutan.</p>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Invalid format'">
									<xsl:choose>
										<xsl:when test="$inputid = 'when'">
												<p>Ange ett datum enligt formatet YYYY-MM-DD (Det är en standard, vi gillar standarder!)</p>
										</xsl:when>
										<xsl:when test="$inputid = 'phone'">
											<p>Det där verkar inte vara ett telefonnummer, håll dig till siffror!</p>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Must select a time in the future'">
									<p>Du måste ta ett datum i framtiden<a href="http://www.youtube.com/watch?v=H3KCnWdiO1k">Dude, you have no quran</a></p>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Invalid'">
									<xsl:choose>
										<xsl:when test="$inputid = 'code' and /root/meta/url_params/code = ''">
											<p>Du måste skriva in koden du fick när du registrerade resan.</p>
										</xsl:when>
										<xsl:when test="$inputid = 'code' and /root/meta/url_params/code != ''">
											<p>Koden du angett stämmer inte. Om du glömt din kod kan du klicka på länken för att få den skickad till dig.</p>
										</xsl:when>
										<xsl:when test="$inputid = 'email'">
											<p>Ingen resa hittades med denna e-postadress. Kontrollera stavingen och försök igen.</p>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Not valid email'">
									<p>Ange en fungerande e-postadress, så du kan ändra eller ta bort din resa.</p>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Must be a future timestamp'">
									<p>Du måste ta ett datum i framtiden<a href="http://www.youtube.com/watch?v=H3KCnWdiO1k">Dude, you have no quran</a></p>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Address is not unique'">
									<p>Vilken adress menar du? Välj i listan!</p>
									<ul>
										<xsl:for-each select="/root/meta/errors/error[data/param = $inputid]/data/option">
											<li>
												<a class="adress">
													<xsl:attribute name="href">
														<xsl:value-of select="/root/meta/path" />
														<xsl:text>?from=</xsl:text>
														<xsl:if test="$inputid = 'from'">
															<xsl:value-of select="." />
															<xsl:text>&amp;to=</xsl:text>
															<xsl:value-of select="/root/meta/url_params/to" />
														</xsl:if>
														<xsl:if test="$inputid = 'to'">
															<xsl:value-of select="/root/meta/url_params/from" />
															<xsl:text>&amp;to=</xsl:text>
															<xsl:value-of select="." />
														</xsl:if>
														<xsl:text>&amp;when=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/when" />
														<xsl:text>&amp;got_car=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/got_car" />
														<xsl:text>&amp;name=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/name" />
														<xsl:text>&amp;email=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/email" />
														<xsl:text>&amp;phone=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/phone" />
														<xsl:text>&amp;details=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/details" />
														<xsl:text>&amp;posted</xsl:text>
													</xsl:attribute>
													<xsl:value-of select="." />
												</a>
											</li>
										</xsl:for-each>
									</ul>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Invalid address'">
									<p>Den här adressen finns inte. Prova att skriva en annan adress eller namnet på staden du vill åka ifrån</p>
								</xsl:when>
								<xsl:otherwise>
									<p>
										<xsl:value-of select="message" />
										<xsl:for-each select="data/option">
											<xsl:value-of select="." /><br />
										</xsl:for-each>
									</p>
								</xsl:otherwise>
							</xsl:choose>
						</label>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<xsl:template name="logo">
		<div class="highfive">
			<xsl:value-of select="' '" />
		</div>
	</xsl:template>

	<xsl:template name="edit_form">
		<form class="trip" method="get" action="/edittrip" id="edittrip">
			<fieldset class="code">
				<h2>Ange din redigeringskod</h2>
				<div id="generals">
					<p class="regular">När du registrerade din resa fick du en kod.</p>
						<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'code'" />
							<xsl:with-param name="inputlabel" select="'Kod'" />
						</xsl:call-template>
					<a class="forgotten" href="/sendcode">Klicka här om du glömt koden och vill få koden mailad till dig.</a>
					<input class="button" type="submit" value="Ändra resa" />
					<input type="hidden" name="posted" />
				</div>
			</fieldset>
		</form>
	</xsl:template>

	<xsl:template name="sendcode_form">
		<form class="trip" method="post" action="/sendcode" id="sendcode">
			<fieldset class="email">
				<h2>Ange din E-postadress</h2>
				<div id="generals">
					<p class="regular">Ange din E-postadress</p>
						<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'email'" />
							<xsl:with-param name="inputlabel" select="'E-post'" />
						</xsl:call-template>
					<input class="button" type="submit" value="Skicka kod" />
				</div>
			</fieldset>
		</form>
	</xsl:template>

	<xsl:template name="message_box">
		<xsl:param name="title" />
		<xsl:param name="message" />
		<div class="message_box">
			<h2><xsl:value-of select="$title" /></h2>
			<p class="regular"><xsl:value-of select="$message" /></p>
		</div>
	</xsl:template>

	<xsl:template name="message">
		<xsl:param name="button" />
		<div id="messages">
			<p>
			<xsl:if test="/root/content/trips/*">
				Om du inte hittar någon resa härunder kan du spara resan så att <em> andra kan hitta dig</em>.
			</xsl:if>
			<xsl:if test="not(/root/content/trips/*)">
				Vi hittade inga resor, prova att ändra i sökningen eller spara din resa.
			</xsl:if>
			</p>
				<a class="button">
					<xsl:attribute name="href">
					<xsl:text>addtrip?from=</xsl:text>
					<xsl:value-of select="/root/meta/url_params/from" />
					<xsl:text>&amp;to=</xsl:text>
					<xsl:value-of select="/root/meta/url_params/to" />
					<xsl:text>&amp;when=</xsl:text>
					<xsl:value-of select="/root/meta/url_params/when" />
					<xsl:text>&amp;got_car=</xsl:text>
					<xsl:if test="/root/meta/url_params/got_car = 1">
						<xsl:value-of select="0" />
					</xsl:if>
					<xsl:if test="/root/meta/url_params/got_car = 0">
						<xsl:value-of select="1" />
					</xsl:if>
				</xsl:attribute>
				Spara resa
			</a>
		</div>
	</xsl:template>

	<xsl:template name="searchresults">
		<xsl:if test="/root/content/trips/*">
			<div id="searchresults">
				<h2>
					<xsl:value-of select="count(/root/content/trips/trip)" />
					<xsl:if test="count(/root/content/trips/trip) = 1">
						<xsl:text> Hittad </xsl:text>
						<xsl:choose>
							<xsl:when test="/root/meta/url_params/got_car = 1">bilplats</xsl:when>
							<xsl:when test="/root/meta/url_params/got_car = 0">passagerare</xsl:when>
							<xsl:otherwise>resa till eller från <xsl:value-of select="/root/meta/url_params/q" /></xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="count(/root/content/trips/trip) > 1">
						<xsl:text> Hittade </xsl:text>
						<xsl:choose>
							<xsl:when test="/root/meta/url_params/got_car = 1">bilplatser</xsl:when>
							<xsl:when test="/root/meta/url_params/got_car = 0">passagerare</xsl:when>
							<xsl:otherwise>resor till eller från <xsl:value-of select="/root/meta/url_params/q" /></xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</h2>
				<table>
					<thead>
						<tr>
							<th class="destination">Från</th>
							<th class="destination">Till</th>
							<th class="time">När</th>
						</tr>
					</thead>
					<tbody>
						<tr class="spacing">
							<td></td>
						</tr>
						<xsl:for-each select="trips/trip">
							<tr>
								<xsl:attribute name="class">
									<xsl:text>generals</xsl:text>
									<xsl:if test="(position() mod 2 = 1)">
										<xsl:text> odd</xsl:text>
									</xsl:if>
									<xsl:if test="(position() mod 2 = 0)">
										<xsl:text> even</xsl:text>
									</xsl:if>
								</xsl:attribute>
								<td>
									<xsl:if test="substring(from,string-length(from) - 7,8) = ', Sweden'">
										<xsl:value-of select="substring(from, 0, string-length(from) - 7)" />
									</xsl:if>
									<xsl:if test="substring(from,string-length(from) - 7,8) != ', Sweden'">
										<xsl:value-of select="from"/>
									</xsl:if>
								</td>
								<td>
									<xsl:if test="substring(to,string-length(to) - 7,8) = ', Sweden'">
										<xsl:value-of select="substring(to, 0, string-length(to) - 7)" />
									</xsl:if>
									<xsl:if test="substring(to,string-length(to) - 7,8) != ', Sweden'">
										<xsl:value-of select="to"/>
									</xsl:if>
								</td>
								<td>
									<xsl:value-of select="substring(when_iso, 0, 11)" />
								</td>
							</tr>
							<tr>
								<xsl:attribute name="class">
									<xsl:text>details</xsl:text>
									<xsl:if test="(position() mod 2 = 1)">
										<xsl:text> odd</xsl:text>
									</xsl:if>
									<xsl:if test="(position() mod 2 = 0)">
										<xsl:text> even</xsl:text>
									</xsl:if>
								</xsl:attribute>
								<td>
									<em>Namn: </em>
									<xsl:value-of select="substring(name, 0)" />
									<br />
									<em>Telefon: </em>
									<xsl:value-of select="substring(phone, 0)" />
								</td>
								<td colspan="2">
									<em>Detaljer: </em>
									<xsl:value-of select="substring(details, 0)" />
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</div>
		</xsl:if>

	</xsl:template>

	<!-- convert line feed to <br /> -->
	<xsl:template name="lf2br">
		<xsl:param name="stringToTransform"/>
		<xsl:choose>
			<xsl:when test="contains($stringToTransform,'&#xA;')">
				<xsl:value-of select="substring-before($stringToTransform,'&#xA;')"/>
				<br/>
				<xsl:call-template name="lf2br">
					<xsl:with-param name="stringToTransform">
						<xsl:value-of select="substring-after($stringToTransform,'&#xA;')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$stringToTransform"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
