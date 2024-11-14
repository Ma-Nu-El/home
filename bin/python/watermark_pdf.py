#!/usr/bin/env python3
# watermark_pdf.py

import argparse
from PyPDF2 import PdfReader, PdfWriter
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from io import BytesIO
import os

def create_watermark(svg_text, level, output_pdf):
    """Create a watermark PDF with the specified level."""
    print(f"Creating watermark (level={level}, text='{svg_text}')...")
    packet = BytesIO()
    c = canvas.Canvas(packet, pagesize=letter)
    width, height = letter

    if level == "low":
        c.setFont("Helvetica", 20)
        c.setFillColorRGB(0.5, 0.5, 0.5, alpha=0.2)
        c.drawString(30, height - 30, svg_text)  # Top edge
        c.drawString(30, 30, svg_text)          # Bottom edge

    elif level == "medium":
        c.setFont("Helvetica", 40)
        c.setFillColorRGB(0.5, 0.5, 0.5, alpha=0.3)
        c.drawCentredString(width / 2, height / 2, svg_text)  # Center

    elif level == "heavy":
        font_size = 10
        c.setFont("Helvetica", font_size)
        c.setFillColorRGB(0.5, 0.5, 0.5, alpha=0.04)
        text_width = c.stringWidth(svg_text, "Helvetica", font_size)

        # Dynamically adjust spacing based on text width
        step_x = text_width + 10  # Add some padding
        step_y = font_size + 10   # Vertical spacing based on font size

        # Dense grid with calculated spacing
        for x in range(0, int(width), int(step_x)):
            for y in range(0, int(height), int(step_y)):
                c.drawString(x, y, svg_text)

    c.save()
    packet.seek(0)
    watermark_pdf = PdfReader(packet)

    with open(output_pdf, 'wb') as f:
        writer = PdfWriter()
        writer.add_page(watermark_pdf.pages[0])
        writer.write(f)
    print(f"Watermark PDF created: {output_pdf}")

def apply_watermark_to_pdf(input_pdf, watermark_pdf, output_pdf):
    """Apply the watermark to the input PDF."""
    print(f"Applying watermark to {input_pdf}...")
    reader = PdfReader(input_pdf)
    writer = PdfWriter()

    watermark = PdfReader(watermark_pdf).pages[0]

    for page in reader.pages:
        page.merge_page(watermark)
        writer.add_page(page)

    with open(output_pdf, "wb") as output:
        writer.write(output)
    print(f"Watermarked PDF saved as: {output_pdf}")

def main():
    parser = argparse.ArgumentParser(description="Watermark a PDF file.")
    parser.add_argument("--file", required=True, help="The PDF file to watermark.")
    parser.add_argument(
        "--level",
        choices=["low", "medium", "heavy"],
        default="medium",
        help="The watermark level: low, medium, or heavy. Default is medium."
    )
    parser.add_argument(
        "--watermark-text",
        default="MFM Watermark",
        help="The text to use for the watermark. Default is 'MFM Watermark'."
    )
    parser.add_argument(
        "--output",
        default="watermarked_output.pdf",
        help="The output PDF file. Default is 'watermarked_output.pdf'."
    )
    args = parser.parse_args()

    watermark_file = "watermark.pdf"

    try:
        create_watermark(args.watermark_text, args.level, watermark_file)
        apply_watermark_to_pdf(args.file, watermark_file, args.output)
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
