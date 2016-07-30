<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output
    method="xml"
    omit-xml-declaration="yes"
    encoding="UTF-8"
    indent="yes" />

<xsl:template match="/">{
	"blocked": <xsl:choose><xsl:when test="(data/params/remote-address-blacklisted = 'yes') or (data/params/remote-address-banned = 'yes')">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
	"messages": [<xsl:choose><xsl:when test="data/params/remote-address-blacklisted = 'yes'">{"message": "Your IP address has been blacklisted."}</xsl:when><xsl:when test="data/params/remote-address-banned = 'yes'">{"message": "Your IP address has been banned."}</xsl:when></xsl:choose>]
}</xsl:template>

</xsl:stylesheet>
