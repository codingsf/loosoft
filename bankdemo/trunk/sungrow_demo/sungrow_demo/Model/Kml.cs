using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.Xml;

namespace sungrow_demo.Model
{
    public class Placemark
    {
        public class KMLPoint
        {
            public KMLPoint()
            {
            }

            public KMLPoint(double latitude, double longitude, string extrude, string altitudemode)
            {
                SetCoordinates(latitude, longitude);
                Extrude = extrude;
                AltitudeMode = altitudemode;
            }

            private string _coordinates;

            public void SetCoordinates(double latitude, double longitude)
            {
                _coordinates = longitude.ToString() + "," + latitude.ToString();
            }

            public string coordinates
            {
                get
                {
                    return _coordinates;
                }

                set
                {
                    _coordinates = value;
                }
            }
            [XmlElement("extrude")]
            public string Extrude { get; set; }


            [XmlElement("altitudeMode")]
            public string AltitudeMode { get; set; }
        }


        public class LookAt
        {
            [XmlElement("longitude")]
            public string longitude { get; set; }

            [XmlElement("latitude")]
            public string latitude { get; set; }

            [XmlElement("altitude")]
            public string altitude { get; set; }

            [XmlElement("range")]
            public string range { get; set; }

            [XmlElement("tilt")]
            public string tilt { get; set; }

            [XmlElement("heading")]
            public string heading { get; set; }

        }


        [XmlElement("name")]
        public string Name { get; set; }

        [XmlElement("description")]
        public string Description { get; set; }

        [XmlElement("visibility")]
        public string Visibility { get; set; }

        [XmlElement("LookAt")]
        public LookAt Look { get; set; }

        [XmlElement("styleUrl")]
        public string StyleUrl { get; set; }


        public KMLPoint Point { get; set; }

        public Placemark()
        {
        }

        public Placemark(string name, string description, string styleUrl,
             string visibility, KMLPoint point, LookAt lookat)
        {
            Name = name;
            Description = description;
            StyleUrl = styleUrl;
            Visibility = visibility;
            Look = lookat;
            Point = point;
        }

    }



    public class GroundOverlay
    {

        public class Look
        {
            [XmlElement("longitude")]
            public string longitude { get; set; }

            [XmlElement("latitude")]
            public string latitude { get; set; }

            [XmlElement("altitude")]
            public string altitude { get; set; }

            [XmlElement("range")]
            public string range { get; set; }

            [XmlElement("tilt")]
            public string tilt { get; set; }

            [XmlElement("heading")]
            public string heading { get; set; }

        }
        public class LatLonBx
        {
            public double north { get; set; }
            public double south { get; set; }
            public double east { get; set; }
            public double west { get; set; }
            public double rotation { get; set; }
        }
        public string name { get; set; }
        public string visibility { get; set; }
        public string icon { get; set; }
        public Look LookAt { get; set; }
        public LatLonBx LatLonBox { get; set; }
    }


    public class kml
    {

        List<Placemark> _Placemarks = new List<Placemark>();
        //List<GroundOverlay> _groundoverlaies = new List<GroundOverlay>();

        //public List<GroundOverlay> GroundOverlaies
        //{
        //    get
        //    {
        //        return _groundoverlaies;
        //    }
        //    set
        //    {
        //        _groundoverlaies = value;
        //    }
        //}

        [XmlArray()]
        public List<Placemark> Document
        {
            get
            {
                return _Placemarks;
            }

            set
            {
                _Placemarks = value;
            }
        }

        public void SetGroundOverlayNode(XmlDocument xmlDoc,List<GroundOverlay> groundoverlaies)
        {
            foreach (GroundOverlay gol in groundoverlaies)
            {
                XmlNode groundoverlayNode = xmlDoc.CreateNode(XmlNodeType.Element, "GroundOverlay", "");

                XmlNode nameNode = xmlDoc.CreateNode(XmlNodeType.Element, "name", "");
                nameNode.InnerText = gol.name;
                XmlNode visibilityNode = xmlDoc.CreateNode(XmlNodeType.Element, "visibility", "");
                visibilityNode.InnerText = gol.visibility;
                XmlNode lookatNode = xmlDoc.CreateNode(XmlNodeType.Element, "LookAt", "");
                XmlNode longitudeNode = xmlDoc.CreateNode(XmlNodeType.Element, "longitude", "");
                longitudeNode.InnerText = gol.LookAt.longitude;
                XmlNode latitudeeNode = xmlDoc.CreateNode(XmlNodeType.Element, "latitude", "");
                latitudeeNode.InnerText = gol.LookAt.latitude;

                XmlNode altitudeNode = xmlDoc.CreateNode(XmlNodeType.Element, "altitude", "");
                altitudeNode.InnerText = gol.LookAt.altitude;

                XmlNode rangeNode = xmlDoc.CreateNode(XmlNodeType.Element, "range", "");
                rangeNode.InnerText = gol.LookAt.range;

                XmlNode tiltNode = xmlDoc.CreateNode(XmlNodeType.Element, "tilt", "");
                tiltNode.InnerText = gol.LookAt.tilt;

                XmlNode headingNode = xmlDoc.CreateNode(XmlNodeType.Element, "heading", "");
                tiltNode.InnerText = gol.LookAt.heading;

                lookatNode.AppendChild(longitudeNode);
                lookatNode.AppendChild(latitudeeNode);
                lookatNode.AppendChild(altitudeNode);
                lookatNode.AppendChild(rangeNode);
                lookatNode.AppendChild(tiltNode);
                lookatNode.AppendChild(headingNode);
                XmlNode iconNode = xmlDoc.CreateNode(XmlNodeType.Element, "Icon", "");
                XmlNode hrefNode = xmlDoc.CreateNode(XmlNodeType.Element, "href", "");
                hrefNode.InnerText = gol.icon;
                iconNode.AppendChild(hrefNode);
                XmlNode latLonBoxNode = xmlDoc.CreateNode(XmlNodeType.Element, "LatLonBox", "");
                XmlNode northNode = xmlDoc.CreateNode(XmlNodeType.Element, "north", "");
                northNode.InnerText = gol.LatLonBox.north.ToString();

                XmlNode southNode = xmlDoc.CreateNode(XmlNodeType.Element, "south", "");
                southNode.InnerText = gol.LatLonBox.south.ToString();

                XmlNode eastNode = xmlDoc.CreateNode(XmlNodeType.Element, "east", "");
                eastNode.InnerText = gol.LatLonBox.east.ToString();

                XmlNode westNode = xmlDoc.CreateNode(XmlNodeType.Element, "west", "");
                westNode.InnerText = gol.LatLonBox.west.ToString();

                XmlNode rotationNode = xmlDoc.CreateNode(XmlNodeType.Element, "rotation", "");
                rotationNode.InnerText = gol.LatLonBox.rotation.ToString();

                latLonBoxNode.AppendChild(northNode);
                latLonBoxNode.AppendChild(southNode);
                latLonBoxNode.AppendChild(eastNode);
                latLonBoxNode.AppendChild(westNode);
                latLonBoxNode.AppendChild(rotationNode);
                groundoverlayNode.AppendChild(nameNode);
                groundoverlayNode.AppendChild(visibilityNode);
                groundoverlayNode.AppendChild(lookatNode);
                groundoverlayNode.AppendChild(iconNode);
                groundoverlayNode.AppendChild(latLonBoxNode);
                XmlNode documentNode = xmlDoc.SelectSingleNode(@"/kml/Document");
                XmlNode placeMarkNode = documentNode.LastChild;
                documentNode.InsertAfter(groundoverlayNode, placeMarkNode);
            }
        }

        private XmlNode GetColorStyle(XmlDocument xmlDoc, string color, string pic, string api_url_root)
        {
            XmlNode style = xmlDoc.CreateNode(XmlNodeType.Element, "Style", "");
            XmlAttribute attr = style.OwnerDocument.CreateAttribute("id");
            attr.Value = color;
            style.Attributes.Append(attr);

            XmlNode balloonStyle = xmlDoc.CreateNode(XmlNodeType.Element, "BalloonStyle", "");
            XmlNode text = xmlDoc.CreateNode(XmlNodeType.Element, "text", "");
            text.InnerText = "<center><b><font size=5>$[name]</font></b></center><br/>$[description]";
            style.AppendChild(balloonStyle);
            balloonStyle.AppendChild(text);

            XmlNode iconStyle = xmlDoc.CreateNode(XmlNodeType.Element, "IconStyle", "");
            XmlNode icon = xmlDoc.CreateNode(XmlNodeType.Element, "Icon", "");
            XmlNode href = xmlDoc.CreateNode(XmlNodeType.Element, "href", "");
            href.InnerText = string.Format(api_url_root+"/"+pic,
                color);
            style.AppendChild(iconStyle);
            iconStyle.AppendChild(icon);
            icon.AppendChild(href);

            XmlNode lineStyle = xmlDoc.CreateNode(XmlNodeType.Element, "LineStyle", "");
            XmlNode width = xmlDoc.CreateNode(XmlNodeType.Element, "width", "");
            width.InnerText = "4";
            style.AppendChild(lineStyle);
            lineStyle.AppendChild(width);

            XmlNode labelStyle = xmlDoc.CreateNode(XmlNodeType.Element, "LabelStyle", "");
            XmlNode lableColor = xmlDoc.CreateNode(XmlNodeType.Element, "color", "");
            lableColor.InnerText = "0000ffff";
            style.AppendChild(labelStyle);
            labelStyle.AppendChild(lableColor);

            return style;
        }

        public void SaveToFile(string xml, List<GroundOverlay> groundoverlaies,string api_url_root)
        {

            XMLHelper.SerializerXML(xml, this);

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(xml);
            xmlDoc.CreateXmlDeclaration("1.0", "utf-8", null);

            XmlNode documentNode = xmlDoc.SelectSingleNode(@"/kml/Document");

            XmlNode placeMarkNode = documentNode.FirstChild;
            //touming
            documentNode.InsertBefore(GetColorStyle(xmlDoc, "globeIcon", "demoimg/2x.png", api_url_root), placeMarkNode);
            //documentNode.InsertBefore(GetColorStyle(xmlDoc, "globeIcon1", "demoimg/2x.png", api_url_root), placeMarkNode);
            //documentNode.InsertBefore(GetColorStyle(xmlDoc, "globeIcon2", "demoimg/2x-1.png", api_url_root), placeMarkNode);

            XmlNode kmlNode = xmlDoc.SelectSingleNode(@"/kml");

            XmlAttribute attr = kmlNode.OwnerDocument.CreateAttribute("xmlns");

            attr.Value = "http://earth.google.com/kml/2.1";

            kmlNode.Attributes.Append(attr);

            SetGroundOverlayNode(xmlDoc, groundoverlaies);

            xmlDoc.Save(xml);

        }

    }
}
