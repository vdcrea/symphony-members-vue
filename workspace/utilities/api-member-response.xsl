<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="api-member-response"><xsl:choose>

    <!-- Member blacklisted -->
    <xsl:when test="data/params/remote-address-blacklisted = 'yes'">{
		"event": {
			"name": "members login info",
			"success": false,
			"messages": [{"message": "Your IP address has been blacklisted."}]
		},
		"user": {
			"logged": false,
			"blacklisted": true,
			"banned": true
		}
	}</xsl:when>

    <!-- Member banned -->
    <xsl:when test="data/params/remote-address-banned = 'yes'">{
		"event": {
			"name": "members login info",
			"success": false,
			"messages": [{"message": "Your IP address has been banned."}]
		},
		"user": {
			"logged": false,
			"blacklisted": false,
			"banned": true
		}
	}</xsl:when>

    <!-- Login info -->
    <xsl:when test="data/events/member-login-info/@result !=''">{
        "event": {
            "name": "members login info",
            "success": <xsl:choose><xsl:when test="data/events/member-login-info/@result = 'success'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
            "messages": [<xsl:for-each select="data/events/member-login-info/child::node()">
                <xsl:if test="@message!=''">{"message": "<xsl:value-of select="@message"/>"}<xsl:if test="./following-sibling::node()[@message!='']">,</xsl:if></xsl:if>
            </xsl:for-each>]
        }<xsl:if test="data/events/member-login-info/@result = 'success'">,
        "user": {
			"logged": true,
			"blacklisted": false,
			"banned": false,
            "id": <xsl:value-of select="data/member/entry/@id"/>,
            "alias": "<xsl:value-of select="data/member/entry/email/@alias"/>",
            "domain": "<xsl:value-of select="data/member/entry/email/@domain"/>",
            "email": "<xsl:value-of select="data/member/entry/email"/>",
            "activated": <xsl:choose><xsl:when test="data/member/entry/activation/@activated = 'yes'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
            "role": "<xsl:value-of select="data/member/entry/role/name/@handle"/>"
        }</xsl:if>
    }</xsl:when>

    <xsl:otherwise>{
        "event": {
            "name": "members login info",
            "success": false
        },
        "user": {
			"logged": false,
			"blacklisted": false,
			"banned": false
		}
    }</xsl:otherwise>

</xsl:choose></xsl:template>

</xsl:stylesheet>
