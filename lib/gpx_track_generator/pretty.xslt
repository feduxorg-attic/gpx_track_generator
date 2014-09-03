<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="node()|@*">
    <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
</xsl:template>


<xsl:template match="things">
    <mainElements>
        <xsl:apply-templates select="thing|comment()"/>
    </mainElements>
</xsl:template>


<xsl:template match="thing">
    <specialThing>
        <xsl:apply-templates select="weight"/>
        <xsl:apply-templates select="color"/>
        <xsl:apply-templates select="state"/>           
    </specialThing>
    <xsl:apply-templates select="comment()[not(following-sibling::*)]"/>
</xsl:template>


<xsl:template match="weight">
    <xsl:apply-templates select="preceding-sibling::comment()[generate-id(following-sibling::*[1])=generate-id(current())]"/>
    <PropertyOne>
        <xsl:value-of select="."/>
    </PropertyOne>
</xsl:template>

<xsl:template match="color">
    <xsl:apply-templates select="preceding-sibling::comment()[generate-id(following-sibling::*[1])=generate-id(current())]"/>
    <PropertyTwo>
        <xsl:value-of select="."/>
    </PropertyTwo>
</xsl:template>

<xsl:template match="state">
    <xsl:apply-templates select="preceding-sibling::comment()[generate-id(following-sibling::*[1])=generate-id(current())]"/>
    <PropertyThree>
        <xsl:value-of select="."/>
    </PropertyThree>
</xsl:template>

</xsl:stylesheet>
