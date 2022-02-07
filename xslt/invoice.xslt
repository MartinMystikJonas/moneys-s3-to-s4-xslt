<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <xsl:strip-space elements="*" />

  <xsl:template match="MoneyData">
    <S5Data>
      <xsl:apply-templates select="SeznamFaktVyd" />
    </S5Data>
  </xsl:template>

  <xsl:template match="SeznamFaktVyd">
    <FakturaVydanaList>
      <xsl:apply-templates select="FaktVyd"/>
    </FakturaVydanaList>
  </xsl:template>

  <xsl:template match="FaktVyd">
    <FakturaVydana>
      <CiselnaRada>
        <Kod>ESHOP</Kod>
      </CiselnaRada>
      <CisloDokladu><xsl:value-of select="Doklad"/></CisloDokladu>
      <DatumPlneni><xsl:value-of select="Vystaveno"/>T00:00:00</DatumPlneni>
      <DatumSkladovehoPohybu><xsl:value-of select="Vystaveno"/>T00:00:00</DatumSkladovehoPohybu>
      <DatumSplatnosti><xsl:value-of select="Splatno"/>T00:00:00</DatumSplatnosti>
      <DatumUcetnihoPripadu><xsl:value-of select="Vystaveno"/>T00:00:00</DatumUcetnihoPripadu>
      <DatumUplatneni><xsl:value-of select="PlnenoDPH"/>T00:00:00</DatumUplatneni>
      <DatumVystaveni><xsl:value-of select="Vystaveno"/>T00:00:00</DatumVystaveni>
      <OdkazNaDoklad>č. <xsl:value-of select="CObjednavk"/></OdkazNaDoklad>
      <VariabilniSymbol><xsl:value-of select="VarSymbol"/></VariabilniSymbol>
      <Vystavil><xsl:value-of select="/MoneyData/@description"/></Vystavil>
      <ZpusobPlatby>
      <xsl:if test="Uhrada = 'plat. kart.'">
        <Kod>KARTA</Kod>
      </xsl:if>
      <xsl:if test="Uhrada = 'hotově'">
        <xsl:choose>
          <xsl:when test=".//Polozka/Popis[text()='Dobírka']">
            <Kod>DOBIRKA</Kod>
          </xsl:when>
          <xsl:otherwise>
            <Kod>HOTOVE</Kod>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      </ZpusobPlatby>
      <Mena>
        <Kod>CZK</Kod>
      </Mena>
      <Adresa>
        <Nazev><xsl:value-of select="DodOdb/FaktNazev"/></Nazev>
        <Misto><xsl:value-of select="DodOdb/FaktAdresa/Misto"/></Misto>
        <PSC><xsl:value-of select="DodOdb/FaktAdresa/PSC"/></PSC>
        <Ulice><xsl:value-of select="DodOdb/FaktAdresa/Ulice"/></Ulice>
        <AdresaStat>
          <Kod><xsl:value-of select="DodOdb/FaktAdresa/KodStatu"/></Kod>
        </AdresaStat>
      </Adresa>
      <AdresaKoncovehoPrijemce>
        <Nazev><xsl:value-of select="DodOdb/ObchNazev"/></Nazev>
        <Misto><xsl:value-of select="DodOdb/ObchAdresa/Misto"/></Misto>
        <PSC><xsl:value-of select="DodOdb/ObchAdresa/PSC"/></PSC>
        <Ulice><xsl:value-of select="DodOdb/ObchAdresa/Ulice"/></Ulice>
        <AdresaStat>
          <Kod><xsl:value-of select="DodOdb/ObchAdresa/KodStatu"/></Kod>
        </AdresaStat>
        <Email><xsl:value-of select="DodOdb/EMail"/></Email>
        <Telefon><xsl:value-of select="DodOdb/Tel/Cislo"/></Telefon>
      </AdresaKoncovehoPrijemce>
      <AdresaPrijemceFaktury>
        <Nazev><xsl:value-of select="DodOdb/ObchNazev"/></Nazev>
        <Misto><xsl:value-of select="DodOdb/ObchAdresa/Misto"/></Misto>
        <PSC><xsl:value-of select="DodOdb/ObchAdresa/PSC"/></PSC>
        <Ulice><xsl:value-of select="DodOdb/ObchAdresa/Ulice"/></Ulice>
        <AdresaStat>
          <Kod><xsl:value-of select="DodOdb/ObchAdresa/KodStatu"/></Kod>
        </AdresaStat>
      </AdresaPrijemceFaktury>
      <IC><xsl:value-of select="DodOdb/ICO"/></IC>
      <DIC><xsl:value-of select="DodOdb/DIC"/></DIC>
      <xsl:apply-templates select="SeznamPolozek"/>
    </FakturaVydana>
  </xsl:template>

  <xsl:template match="SeznamPolozek">
    <Polozky  ObjectName="PolozkaFakturyVydane" ObjectType="List">
      <xsl:apply-templates select="Polozka"/>
    </Polozky>
  </xsl:template>

  <xsl:template match="Polozka">
    <PolozkaFakturyVydane ObjectName="PolozkaFakturyVydane" ObjectType="Object">
      <Nazev><xsl:value-of select="Popis"/></Nazev>
      <JednCena><xsl:value-of select="Cena"/></JednCena>
      <xsl:if test="Sleva != 0">
        <Sleva><xsl:value-of select="Sleva div Cena * 100"/></Sleva>
      </xsl:if>
      <DPH>
        <Sazba><xsl:value-of select="SazbaDPH"/>.00</Sazba>
      </DPH>
      <TypCeny>1</TypCeny>
      <Mnozstvi><xsl:value-of select="PocetMJ"/></Mnozstvi>
    </PolozkaFakturyVydane>
  </xsl:template>

</xsl:stylesheet>