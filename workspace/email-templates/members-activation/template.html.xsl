<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes"/>

<xsl:template match="/">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>&#128172; Welcome to <xsl:value-of select="$website-name"/></title>
	</head>
	<body>
		<table width="100%" border="0" cellpadding="20px" cellspacing="0">
			<tr>
				<td align="center">
					<table width="320px" border="0" cellpadding="0" cellspacing="0" style="font-family: 'HelveticaNeue-Light', 'Helvetica Neue Light', 'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif; font-weight: 300; font-size: 13px; color: #000;">
						<tr>
							<td align="center">
								<h1 style="font-weight: normal;">
									<!-- <img src="{$workspace}/assets/img/xxx.jpg" /><br/> -->
									Hello <xsl:value-of select="data/members-notifications/entry/email/@alias"/>,</h1>
								<p>Welcome to <xsl:value-of select="$website-name"/>, please activate your account</p>
								<a href="{$root}/activation/{data/members-notifications/entry/email}/{data/members-notifications/entry/activation/code}" style="display: block; padding: 5px 0px 7px 0px; background: #1fc8db; color: #fff; text-decoration: none;">&#160;Activate my account&#160;</a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
</xsl:template>
</xsl:stylesheet>
